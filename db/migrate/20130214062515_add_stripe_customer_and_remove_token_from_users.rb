class AddStripeCustomerAndRemoveTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :card_token
    add_column :users, :stripe_customer_id, :string, :null => true
  end
end
