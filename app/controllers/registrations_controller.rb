class RegistrationsController < Devise::SessionsController
  def new

  end

  def create

    @email = User.find_by(email: register_params[:email])
    unless @email
      # @pass = User.find_by(password_digest: register_params[:password_digest])
      # if !@pass
          @resource = User.new params[:register_params]
          if @resource.save
            # log_in @user
            redirect_to root_path, notice: t("register.message")
          else
            redirect_to register_path, notice: t("register.invalid")
          end
      # else
      #   flash[:alert] = t("register.invalid_pass")
      #   render :new
      # end
    else
      flash[:alert] = t("register.invalid_email")
      render :new
    end
  end

  private

  def register_params
    allow = [:username, :password_digest, :password_confirmation,
        :first_name, :last_name, :email, :phone, :role_id]
    params.require(:resource_name).permit(allow)
  end
end
