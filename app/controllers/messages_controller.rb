class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def new
    item = Item.find(params[:item_id])
    @message = item.messages.build
  end

  def create
    item = Item.find(params[:item_id])
    @message = item.messages.build params[:message]
    @message.sender = current_user
    @message.item = item
    @message.recipient = item.seller
    if @message.save
      flash[:notice] = t(:new_message_sent)
      redirect_to item_path(item)
    else
      render :new
    end
  end
end
