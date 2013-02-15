require 'stripe'

class CreateCustomer
  @queue = :create_customer
  
  def self.perform(user_id, card_token)
    user = User.find(user_id)
    stripe_customer = Stripe::Customer.create(
      :description => "Customer email #{user.email}",
      :card => card_token
    )
    user.stripe_customer_id = stripe_customer.id
    user.save
  end
end
