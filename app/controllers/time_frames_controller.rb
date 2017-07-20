class TimeFramesController < ApplicationController
  before_action :load_timeframe, only: [:edit, :update]

  def index
    @time_frames = TimeFrame.all.paginate(page: params[:page],
      per_page: Settings.paging.per_page)
    @speakers = Speaker.all
    @events = Event.all
  end

  def list; end

  def new
    @time_frame = TimeFrame.new
    @room = Room.new
    @event = Event.new
    @speaker = Speaker.new
  end

  def edit; end

  def show
    @time_frames = TimeFrame.all.paginate(page: params[:page], per_page: Settings.paging.per_page)
    render action: "index"
  end

  def create
    @time_frame = TimeFrame.new(time_frame_params)
    respond_to do |format|
      if @time_frame.save
        format.html { redirect_to time_frames_url, notice: t("tf.msg_create")  }
        format.json { render :index, status: :created, location: @time_frame }
      else
        format.html { render :new }
        format.json { render json: @time_frame.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @time_frame.update(time_frame_params)
        format.html { redirect_to time_frames_url, notice: t("tf.msg_update")  }
        format.json { render :index, status: :ok, location: @time_frame }
      else
        format.html { render :edit }
        format.json { render json: @time_frame.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if !params[:del_timeframe_ids].blank?
      TimeFrame.delete(params[:del_timeframe_ids])
      respond_to do |format|
        format.html { redirect_to time_frames_url, notice: t("tf.msg_delete") }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to time_frames_url, error: t("error2") }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def load_timeframe
       @time_frame = TimeFrame.find_by(id: params[:id])
       redirect_to time_frames_url, notice: t("tf.load_error") if @time_frame.nil?
    end

    def time_frame_params
      params.require(:time_frame).permit(:tf_title, :tf_start, :tf_end, :sp_id, :ev_id, :ro_id)
    end
end
