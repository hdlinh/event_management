class SessionsController < Devise::SessionsController
  before_action :prevent_logged_in_user_access, except: :destroy
  before_action :prevent_unauthorized_user_access, only: :destroy
  skip_before_action :verify_authenticity_token

  def new

  end

  def member_login
    render :member_login
  end

  def create
    user = User.find_by(email: login_params[:email])
    user_pass = user.authenticate(login_params[:password])

    if user && (user_pass && user.password_digest)
        log_in(user)
        redirect_to users_url, notice: t("devise_modal.login.login")
    else
        flash[:alert] = t("login.alert")
        render :new
    end

  end

  def create_member_login
    member = Member.find_by(email: member_login_params[:email])
    member_pass = member.authenticate(member_login_params[:password])
    # byebug
    if member && (member_pass && member.password_digest)
      session[:member_id] = member.id
      redirect_to root_url, notice: t("login.login")
    else
      flash[:alert] = t("login.alert")
      render :member_login
    end
  end

  def member_logout
    session[:member_id] = nil
    redirect_to root_url, notice: t("login.logout")
  end

  def omniauth_create
    # binding.pry
    user = User.from_omniauth(request.env["omniauth.auth"])
    log_in(user)
    redirect_to users_url, notice: t("login.login")
  end

  def destroy
    log_out
    redirect_to new_session_path, notice: t("login.logout")
  end

  protected
  def login_params
    params.require(:user).permit(:email, :password)
  end

  def member_login_params
    params.require(:member).permit(:email, :password)
  end
end
