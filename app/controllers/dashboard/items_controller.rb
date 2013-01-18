class Dashboard::ItemsController < Dashboard::ApplicationController
  def index
    @items = current_user.items
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build description:  params[:item][:description],
                                     contact_info: params[:item][:contact_info]
    if @item.save
      @item.set_tags params[:item][:tags_s]
      flash[:notice] = t :item_created
      redirect_to dashboard_items_path
    else
      render action: 'new'
    end
  end

  def destroy
    current_user.items.find(params[:id]).destroy

    flash[:notice] = t :item_destroyed
    redirect_to dashboard_items_path
  end
end
