class Dashboard::PhotosController < Dashboard::ApplicationController
  def new
    @item_id = params[:item_id]
    @photo = current_user.items.find(@item_id).photos.build
  end

  def create
    @photo = current_user.items.find(params[:item_id]).photos.build params[:photo]

    if @photo.save
      flash[:notice] = t :photo_added
      redirect_to dashboard_items_path
    end
  end
end
