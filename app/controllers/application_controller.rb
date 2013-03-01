class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def after_sign_in_path_for(user)
    unless user.has_any_role?(:admin, :user)
      user.grant :user
    end
    session.delete(:user_return_to) || dashboard_items_path
  end

  def set_locale
    if params[:locale]
      if I18n.available_locales.include? params[:locale].to_sym
        I18n.locale = params[:locale]
      else
        I18n.locale = support_or_default_locale
        flash[:notice] =  I18n.t(:locale_not_support, :wrong_locale => params[:locale])
        redirect_to url_for(locale: I18n.locale, only_path: true)
      end
    else
      I18n.locale = support_or_default_locale
      redirect_to url_for(locale: I18n.locale, only_path: true)
    end
  end
  
  def default_url_options(options={})
    { locale: I18n.locale, only_path: true }
  end

  def authenticate_user_and_return_to(path)
     session[:user_return_to] = path
     authenticate_user!
  end

private

  def support_or_default_locale
    http_accept_language.preferred_language_from(I18n.available_locales) || I18n.default_locale
  end
end
