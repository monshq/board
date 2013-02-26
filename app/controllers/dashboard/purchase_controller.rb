class Dashboard::PurchaseController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    
    if item.price.blank?
      raise ActiveRecord::RecordNotFound
    end
    
    if current_user.stripe_customer_id.blank?
      redirect_to dashboard_card_index_path
    else
      PurchasesService.create_payment_transaction(current_user, item)
      redirect_to dashboard_transactions_path
    end
  end
end
