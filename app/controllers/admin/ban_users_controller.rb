class Admin::BanUsersController < Admin::ApplicationController

  def new
    @user = User.find(params[:user_id])
    @admin_comment = @user.admin_comments.build({ action_type: 'Ban' }) # TODO: добавить action type в локализации
  end

  def create
    @user = User.find(params[:user_id])
    @user.ban
    redirect_to users_path
  end

  def destroy
    @user = User.find(params[:user_id])
    @user.allow
    redirect_to users_path
  end
end
