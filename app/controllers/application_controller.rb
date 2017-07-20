class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper
  before_action :store_current_location, :unless => :devise_controller?
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      log_out
      root_path
    else
      new_session_path
    end
  end

  helper_method :current_user, :logged_in?

  private
  # override the devise helper to store the current location so we can
  # redirect to it after loggin in or out. This override makes signing in
  # and signing up work automatically.
  def store_current_location
    store_location_for(:user, request.url)
  end

  def prevent_unauthorized_user_access
    redirect_to new_session_path, notice: t("login.error"), status: :found unless logged_in?
  end

  def prevent_logged_in_user_access
    redirect_to new_session_path, notice: t("login.error"), status: :found if logged_in?
  end
end
