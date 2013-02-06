class Admin::AdminsController < Admin::ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    session[:source_user] ||= current_user.id
    sign_in(@user, bypass: true)
    redirect_to after_sign_in_path_for(@user)
  end

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
