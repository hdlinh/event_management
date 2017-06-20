class Speaker < ApplicationRecord
  mount_uploader :sp_avatar, ImageUploader
  has_one :time_frame, dependent: :destroy

  validates :sp_firstname, :sp_lastname, :sp_phone,
    :sp_email, presence: { message: I18n.t("speaker.invalid_val") }
  validates :sp_phone, numericality: {  message: I18n.t("speaker.phone_num") },
    length: {
      minimum: Settings.speaker.min_phone_len,
      maximum: Settings.speaker.max_phone_len,
      message: I18n.t("speaker.phone_val")
    }
  validates :sp_email, email_format: { message: I18n.t("speaker.email_val") }
  validates :sp_avatar, presence: { message: I18n.t("speaker.avatar_val") }

end
