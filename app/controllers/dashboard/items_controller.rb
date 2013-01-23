class Dashboard::ItemsController < Dashboard::ApplicationController
  def index
    @items = current_user.items
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build params[:item]

    if @item.save
      @item.set_tags params[:tags]
      flash[:notice] = t :item_created
      redirect_to dashboard_items_path
    else
      render action: 'new'
    end
  end

  def edit
    @item = current_user.items.find(params[:id])
  end

  def update
    @item = current_user.items.find(params[:id])

    if @item.update_attributes(params[:item])
      @item.set_tags(params[:tags])

      redirect_to dashboard_items_path, notice: t('item.notice.updated')
    else
      render action: "edit"
    end
  end

  def destroy
    current_user.items.find(params[:id]).destroy

    flash[:notice] = t :item_destroyed
    redirect_to dashboard_items_path
  end
end
