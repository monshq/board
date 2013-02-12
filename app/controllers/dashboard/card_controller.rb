class Dashboard::CardController < ApplicationController
  def index
  end
  
  def create
    current_user.card_token = params[:stripeToken]
    current_user.save! #execption if errors on save
    flash[:notice] = t :card_saved
    render action: 'index'
  end
end
