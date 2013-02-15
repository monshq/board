class MessagesController < ApplicationController
  #before_filter :authenticate_user!

  def new
    item = Item.find(params[:item_id])
    @message = item.messages.build session.delete(:message)
    if @message.text.present?
      send_message(@message)
    end
  end

  def create
    item = Item.find(params[:item_id])
    if current_user
      send_message item.messages.build(params[:message])
    else
      session[:message] = params[:message]
      session[:user_return_to] = new_item_message_path(item)
      redirect_to new_user_session_path
    end
  end

  def send_message(message)
    message.sender = current_user
    message.recipient = @message.item.seller
    if message.save
      flash[:notice] = t(:new_message_sent)
      redirect_to item_path(@message.item)
    else
      render :new
    end
  end
end
