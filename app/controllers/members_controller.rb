class MembersController < ApplicationController
  def new
    @member = Member.new
  end

  def create
    email = Member.find_by(email: allowed_params[:email])
    if email.nil?
      @member = Member.new(allowed_params)
      if @member.save
        redirect_to root_path, notice: t("devise_modal.sign_up")
      else
        flash[:alert] = t("devise_modal.login.invalid_pass")
        render :new
      end
    else
      flash[:alert] = t("login.invalid_email")
      render :new
    end

  end

  private

  def allowed_params
    params.require(:member).permit(:email, :password, :password_confirmation)
  end
end
