class Dashboard::ItemsController < Dashboard::ApplicationController
  def index
    @items = current_user.items
  end
end
