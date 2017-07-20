class Speaker < ApplicationRecord
  mount_uploader :sp_avatar, ImageUploader
  belongs_to :events




  validates :sp_firstname, :sp_lastname, :sp_phone,
    :sp_email, presence: { message: I18n.t("invalid_val") }
  validates :sp_phone, numericality: {  message: I18n.t("phone_num") },
    length: {
      minimum: Settings.speaker.min_phone_len,
      maximum: Settings.speaker.max_phone_len,
      message: I18n.t("phone_val")
    }
  validates :sp_email, email_format: { message: I18n.t("email_val") }
  validates :sp_avatar, presence: { message: I18n.t("speaker.avatar_val") }

   #"SELECT * FROM speakers
  # INNER JOIN time_frames AS tf ON speakers.id = tf.sp_id
  # INNER JOIN events ON tf.ev_id = events.id AND events.id = "+ params[:id]
  # scope :load_speaker, ->(evt_id) do
  #   joins("INNER JOIN time_frames AS tf ON speakers.id = tf.speaker_id
  #    INNER JOIN events ON tf.event_id = events.id AND events.id =", evt_id)
  # end
end
