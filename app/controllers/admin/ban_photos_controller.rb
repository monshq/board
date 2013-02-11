class Admin::BanPhotosController < Admin::ApplicationController

  def new
    @photo = Photo.find(params[:photo_id])
    @admin_comment = @photo.build_admin_comment({ action_type: 'Ban' })
  end

  def create
    @photo = Photo.find(params[:photo_id])

    @photo.build_admin_comment params[:admin_comment]

    if @photo.save
      flash[:notice] = "Photo banned" # TODO: Добавить локализацию

      @photo.ban

      BoardMailer.photo_banned_email(request.protocol, request.host_with_port, @photo, params[:admin_comment][:comment]).deliver
      redirect_to items_path
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @photo.allow
    redirect_to items_path
  end

end
