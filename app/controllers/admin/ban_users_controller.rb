class Admin::BanUsersController < Admin::ApplicationController

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
