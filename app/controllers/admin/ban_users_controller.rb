class Admin::BanUsersController < Admin::ApplicationController

  def new
    @user = User.find(params[:user_id])
    @admin_comment = @user.admin_comments.build({ action_type: 'Ban' })
  end

  def create
    @user = User.find(params[:user_id])

    @user.admin_comments.build params[:admin_comment]

    if @user.save
      flash[:notice] = "User banned" # TODO: Добавить локализацию
      @user.ban

      redirect_to users_path
    end

  end

  def destroy
    @user = User.find(params[:user_id])
    @user.allow
    redirect_to users_path
  end
end
