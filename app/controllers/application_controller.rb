class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper
  # before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
 end
