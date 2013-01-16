class Dashboard::ItemsController < Dashboard::ApplicationController
  def index
    @items = current_user.items
  end

  def new
    @item = current_user.items.new
  end

  def create
    if current_user.items.create params[:item]
      flash[:notice] = t :item_created
      redirect_to dashboard_items_path
    end
  end
end
