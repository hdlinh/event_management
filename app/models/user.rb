class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :role, dependent: :destroy
  # has_many :time_frames
  include UsersHelper

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, email_format: { message: I18n.t("email_val") }
  validates :phone, numericality: {  message: I18n.t("phone_num") },
    length: {
      minimum: Settings.speaker.min_phone_len,
      maximum: Settings.speaker.max_phone_len,
      message: I18n.t("phone_val")
    }

end
