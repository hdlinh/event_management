class EventsController < ApplicationController
  before_action :load_event, only: [:show, :edit, :update]

  def index
    @events = Event.all.paginate(page: params[:page], per_page: Settings.paging.per_page)
  end

  def new
    @event = Event.new
  end

  def show
    # Lay tat ca thong tin Event de hien thi ra main page - slide bar
    @events = Event.all
    # Lay Tat ca cac thong tin Speaker trong tung Event hien thi ra main page
    @speakers = @event.speakers
  end

  def edit; end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_url, notice: t("event.msg_create") }
        format.json { render :index, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_url, notice: t("event.msg_update") }
        format.json { render :index, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if !params[:del_event_ids].blank?
      Room.delete(params[:del_event_ids])
      respond_to do |format|
        format.html { redirect_to events_url, notice: t("event.msg_delete") }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to events_url, notice: t("error2") }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def load_event
      @event = Event.find_by(id: params[:id])
      redirect_to events_url, notice: t("event.load_error") if @event.nil?
    end

    def event_params
      params.require(:event).permit(:ev_name, :ev_description, :ev_date)
    end
end
