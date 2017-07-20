class SessionsController < Devise::SessionsController
  #before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new

  end

  # POST /resource/sign_in
  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:encrypted_password])
      log_in user
      #params[:session][:remember_me] == Setting.number ? remember(user) : forget(user)
      # redirect_to user
      # session[:user_id] = user.id
      redirect_to url_for(:controller => "time_frames", :action => "index")
    else
      flash[:alert] = t("login.invalid")
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
