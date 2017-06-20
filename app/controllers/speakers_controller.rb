class SpeakersController < ApplicationController
  before_action :load_speaker, only: [:edit, :update]

  def index
    @speakers = Speaker.all.paginate(page: params[:page], per_page: Settings.room.per_page)
    @events = Event.all
  end

  def new
    @speaker = Speaker.new
    @events = Event.new
  end

  def show
    @speakers = Speaker.find_by(id: params[:id])
  end

  def edit; end

  def create
    @speaker = Speaker.new(speaker_params)
    respond_to do |format|
      if @speaker.save
        format.html { redirect_to speakers_url, notice: t("speaker.msg_create") }
        format.json { render :index, status: :created, location: @speaker }
      else
        format.html { render :new }
        format.json { render json: @speaker.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @speaker.update(speaker_params)
        format.html { redirect_to @speaker, notice: t("speaker.msg_update") }
        format.json { render :index, status: :ok, location: @speaker }
      else
        format.html { render :edit }
        format.json { render json: @speaker.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if !params[:del_speaker_ids].blank?
      Speaker.delete(params[:del_speaker_ids])
      respond_to do |format|
        format.html { redirect_to speakers_url, notice: t("speaker.msg_delete") }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to speakers_url, notice: t("errors") }
        format.json { render json: @room.errors, status: :unprocessable_entity}
      end
    end
  end

  private
    def speaker_params
      params.require(:speaker).permit(:sp_firstname, :sp_lastname, :sp_major, :sp_email, :sp_phone, :sp_description, :sp_avatar)
    end

    def load_speaker
      @speaker = Speaker.find_by(id: params[:id])
      redirect_to speakers_url, notice: t("speaker.load_error") if @speaker.nil?
    end
end
