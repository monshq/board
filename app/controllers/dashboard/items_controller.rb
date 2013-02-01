class Dashboard::ItemsController < Dashboard::ApplicationController
  def index
    @items = current_user.items.active
  end

  def new
    @item = current_user.items.active.build
  end

  def create
    @item = current_user.items.active.build params[:item]

    if @item.save
      @item.set_tags params[:tags]
      @item.set_tags_hashes
      flash[:notice] = t :item_created
      redirect_to dashboard_items_path
    else
      render action: 'new'
    end
  end

  def edit
    @item = current_user.items.active.find(params[:id])
  end

  def update
    @item = current_user.items.active.find(params[:id])

    if @item.update_attributes(params[:item])
      @item.set_tags(params[:tags])

      unless @item.visible_for_seller?
        @item.archivate
      end
      redirect_to dashboard_items_path, notice: t(:item_updated)
    else
      render action: "edit"
    end
  end

end
