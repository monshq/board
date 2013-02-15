class Dashboard::BuyingItemController < ApplicationController

  def show
    item = Item.find(params[:id])
    if current_user.stripe_customer_id.blank?
      redirect_to dashboard_card_index_path
    else
      transaction = current_user.pay_for_item(item)
      redirect_to dashboard_transactions_path
    end
  end
end
