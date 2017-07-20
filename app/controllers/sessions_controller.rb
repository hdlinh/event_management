class SessionsController < Devise::SessionsController
  before_action :prevent_logged_in_user_access, except: :destroy
  before_action :prevent_unauthorized_user_access, only: :destroy

  # GET /resource/sign_in
  def new
    # super
  end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: login_params[:email])
    if user
      pass = User.find_by(password_digest: login_params[:password_digest])
      if pass
        log_in(user)
        #params[:session][:remember_me] == Setting.number ? remember(user) : forget(user)
        redirect_to users_url, notice: t("login.login")
      else
        flash[:alert] = t("login.invalid_pass")
        render "new"
      end
    else
      flash[:alert] = t("login.invalid_email")
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to new_session_path, notice: t("login.logout")
  end

  private
  def login_params
     params.require(:session).permit(:email, :password_digest)
  end
end
