class Dashboard::CardController < ApplicationController
  def index
  end
  
  def create
    Resque.enqueue(CreateCustomer, current_user.id, params[:stripeToken])
    flash[:notice] = t :card_saved
    render action: 'index'
  end
end