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
end
