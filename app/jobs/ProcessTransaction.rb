require 'stripe'

class ProcessTransaction
  @queue = :process_transaction
  
  def self.perform(transaction_id)
    transaction = Transaction.find(transaction_id)
    transaction.tries = transaction.tries - 1
    charge = Stripe::Charge.create(
      :amount => (100*transaction.amount).round, #charge in cents
      :currency => 'usd',
      :customer => transaction.user.stripe_customer_id)
    transaction.charge_id = charge.id
    transaction.accept
    
  rescue Stripe::APIConnectionError => e
    transaction.error_message = e.json_body[:error][:message]
    if transaction.tries <= 0
      Resque.enqueue_in(self.process_transaction_delay(transaction), ProcessTransaction, transaction.id)
    end
  
  rescue => e
    transaction.error_message = e.respond_to?(:json_body) ? e.json_body[:error][:message] : e.message
    transaction.reject
    
  ensure
    transaction.save
  end

  private

  def self.process_transaction_delay(transaction)
    # некий алгоритм определения задержки обработки тарнзакции в случае ошибки
    if transaction.tries >=5
      return 2.seconds
    elsif transaction.tries >= 2
      return 5.seconds
    end
    10.seconds
  end
end
