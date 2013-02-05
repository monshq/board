class SessionsController < Devise::SessionsController

  def destroy
    if session[:source_user].present?
      user = User.find(session[:source_user])
      session[:source_user] = nil
      sign_in(user, bypass: true)
      redirect_to after_sign_in_path_for(user)
    else
      super
    end
  end

end
