class Admin::BanPhotosController < Admin::ApplicationController

  def new
    @photo = Photo.find(params[:photo_id])
    @admin_comment = @photo.admin_comments.build({ action_type: 'Ban' })
  end

  def create

  end

end
