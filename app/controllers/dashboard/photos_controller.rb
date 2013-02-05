class Dashboard::PhotosController < Dashboard::ApplicationController
  def new
    @item = current_user.items.find params[:item_id]
  end

  def create
    @item = current_user.items.find params[:item_id]
    @item.photos.build params[:photo]

    if @item.save
      flash[:notice] = t :photo_added
      redirect_to dashboard_items_path
    end
  end

  def index
    @item = current_user.items.find params[:item_id]
    @photos = @item.photos

    render
  end

  def edit
    item = current_user.items.find params[:item_id]
    photo = item.photos.find params[:id]

    item.photos.update_all(is_main: false)
    photo.update_attributes(is_main: true)

    flash[:notice] = t :photo_made_main
    redirect_to dashboard_item_photos_path(item)
  end

end
