class Admin::UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  # skip_before_action :verify_authenticity_token

  def index
    @users = User.order_by_id.paginate(page: params[:page],
      per_page: Settings.paging.per_page)
  end

  def new
    # if logged_in?
      @user = User.new
      @role = Role.new
    # else
      # render "sessions/new"
    # end
  end

  def edit; end
  def show; end

  def create
    @user = User.new user_params
    # byebug
    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to admin_user_url, notice: t("user.msg_create") }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { redirect_to new_admin_user_url, notice: t("errors") }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_url, notice: t("user.msg_update") }
        format.json { render :index, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      unless params[:del_user_ids]
        Speaker.delete(params[:del_user_ids])
        format.html { redirect_to admin_user_url, notice: t("user.msg_delete") }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_user_url, notice: t("errors") }
        format.json { render json: @room.errors, status: :unprocessable_entity}
      end
    end
  end

  private
    def load_user
      @user = User.find_by(id: params[:id])
      return if @user
      redirect_to users_url, notice: t("user.load_error")
    end

    def user_params
      params.require(:user).permit(:username, :encrypted_password, :password_confirmation,
        :first_name, :last_name, :email, :phone, :role_id)
    end
end
