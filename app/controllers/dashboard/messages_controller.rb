class Dashboard::MessagesController < Dashboard::ApplicationController
  def index
    @items = current_user.items.active.has_messages
#    abort(@items.to_sql)
  end

  def show
    #@message = current_user.received_messages.find(params[:id])
  end
end