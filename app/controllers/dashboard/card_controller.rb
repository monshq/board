class Dashboard::CardController < ApplicationController
  def index
  end
  
  def create
    stripe_customer = Stripe::Customer.create(
      :description => "Customer email #{current_user.email}",
      :card => params[:stripeToken]
    )
    current_user.stripe_customer_id = stripe_customer.id
    current_user.save! #execption if errors on save
    flash[:notice] = t :card_saved
    render action: 'index'
  end
end