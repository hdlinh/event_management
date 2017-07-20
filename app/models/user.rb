class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :role, dependent: :destroy, optional: true
  has_secure_password
  include UsersHelper

  devise :database_authenticatable, :confirmable,
    :recoverable, :rememberable, :trackable, :encryptable

  validates :username, presence: true
  validates :password_digest, presence: true
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, email_format: { message: I18n.t("email_val") }
  validates :phone, numericality: {  message: I18n.t("phone_num") },
    length: {
      minimum: Settings.speaker.min_phone_len,
      maximum: Settings.speaker.max_phone_len,
      message: I18n.t("phone_val")
    }


end
