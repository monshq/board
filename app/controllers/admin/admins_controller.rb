class Admin::AdminsController < Admin::ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    # authorize_action_for(current_user)
    session[:source_user] ||= current_user.id
    sign_in(@user, bypass: true)
    redirect_to after_sign_in_path_for(@user)
  end
end
