module SessionsHelper

  def log_in user
    session[:user_id] = user.id
  end

  def authenticate
    redirect_to :login unless user_signed_in?
  end

  def authenticate!
    if !current_user
      redirect_to root_url, notice: t('devise.failure.unauthenticated')
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def current_user? user
    user == current_user
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    current_user.nil? ? false : true
  end

  def log_out
    session.delete(:user_id)
    # forget current_user
    @current_user = nil
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end
end
