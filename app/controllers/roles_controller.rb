class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_role, only: [:edit, :update]

  def index
    @roles = Role.all.paginate(page: params[:page], per_page: Settings.paging.per_page)
  end

  def new
    @role = Role.new
  end

  def edit; end

  def create
    @role = Role.new role_params
    respond_to do |format|
      if @role.save
        format.html { redirect_to roles_url, notice: t("role.msg_create") }
        format.json { render :index, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to roles_url, notice: t("role.msg_update") }
        format.json { render :index, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if !params[:del_role_ids].blank?
      Role.delete(params[:del_role_ids])
      respond_to do |format|
        format.html { redirect_to roles_url, notice: t("role.msg_delete") }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to roles_url, notice: t("errors") }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_role
      @role = Role.find_by(id: params[:id])
      redirect_to roles_url, notice: t("role.load_error") if @role.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:role_name, :role_description)
    end
end
