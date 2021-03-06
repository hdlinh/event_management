class RoomsController < ApplicationController
   before_action :load_room, only: [:edit, :update]
   before_action :authenticate_user!

  def index
    @rooms = Room.all.paginate(page: params[:page], per_page: Settings.room.per_page)
  end

  def new
    @room = Room.new
  end

  def edit; end

  def create
    @room = Room.new(room_params)
    respond_to do |format|
      if @room.save
        format.html { redirect_to rooms_url, notice: t("rooms.msg_create") }
        format.json { render :index, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to rooms_url, notice: t("rooms.msg_update") }
        format.json { render :index, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if !params[:del_room_ids].blank?
      Room.delete(params[:del_room_ids])
      respond_to do |format|
        format.html { redirect_to rooms_url, notice: t("rooms.msg_delete") }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to rooms_url, notice: t("error2") }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def room_params
      params.require(:room).permit(:ro_name, :ro_type)
    end

    def load_room
       @room = Room.find_by(id: params[:id])
       redirect_to rooms_url, notice: t("rooms.load_error") if @room.nil?
    end
end
