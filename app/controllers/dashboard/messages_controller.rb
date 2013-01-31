class Dashboard::MessagesController < Dashboard::ApplicationController
  def index
    #@items = current_user.items.active.with_messages

    @messages = current_user.received_messages.unread

  end

  def show
    #@message = current_user.received_messages.find(params[:id])
  end
end
