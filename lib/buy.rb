module Buy
  def self.create_payment_transaction(user, item)
    transaction = user.transactions.create(
      :amount => item.price,
      :item => item,
      :state => :untreated)
    Resque.enqueue(ProcessTransaction, transaction.id)
    item.reserve
    transaction
  end
end
