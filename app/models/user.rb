class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :role, dependent: :destroy
  # has_many :time_frames
  #before_save :encrypt_password
  before_save { |user| user.email = email.downcase }
  include UsersHelper

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #has_secure_password
  validates :username, presence: true
  validates :password_digest, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validates_confirmation_of :password
  validates :first_name, :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :phone, numericality: true,
    length: {
      minimum: Settings.speaker.min_phone_len,
      maximum: Settings.speaker.max_phone_len,
      message: I18n.t("phone_val")
    }

  scope :order_by_id, -> {order(id: :asc)}
end
