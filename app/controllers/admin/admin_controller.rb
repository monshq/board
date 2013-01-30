class Admin::AdminController < Admin::ApplicationController
  before_filter :authenticate_user!

  def become_user
    return unless current_user.has_role?(:admin)
    sign_in User.find(params[:id]), bypass: true
    redirect_to root_url # or user_root_url
  end
end
