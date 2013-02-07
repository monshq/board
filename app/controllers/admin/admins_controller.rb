class Admin::AdminsController < Admin::ApplicationController

  def ban_user
    @user = User.find(params[:user_id])
    @user.ban
    redirect_to users_path
  end

  def allow_user
    @user = User.find(params[:user_id])
    @user.allow
    redirect_to users_path
  end

end
