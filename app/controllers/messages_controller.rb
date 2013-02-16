class MessagesController < ApplicationController
  def new
    item = Item.find(params[:item_id])
    if params[:return] && current_user
      @message = item.messages.build session.delete(:message)
      send_message
    else
      @message = item.messages.build
    end
  end

  def create
    item = Item.find(params[:item_id])
    if current_user
      @message = item.messages.build(params[:message])
      send_message
    else
      session[:message] = params[:message]
      session[:user_return_to] = new_item_message_path(item, :return => true)
      authenticate_user!
    end
  end

private
  def send_message
    @message.sender = current_user
    @message.recipient = @message.item.seller
    if @message.save
      flash[:notice] = t(:new_message_sent)
      redirect_to item_path(@message.item)
    else
      render :new
    end
  end
end
