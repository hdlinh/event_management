class User < ApplicationRecord
  has_one :role, dependent: :destroy
  # has_many :time_frames
  #before_save :encrypt_password
  before_save { |user| user.email = email.downcase }
  include UsersHelper

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:google_oauth2]

  has_secure_password
  # validates :username, presence: true
  validates :password, presence: true
  # validates :encrypted_password, confirmation: true

  # validates :first_name, :last_name, presence: true
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  # validates :phone, numericality: true,
  #   length: {
  #     minimum: Settings.speaker.min_phone_len,
  #     maximum: Settings.speaker.max_phone_len,
  #     message: I18n.t("phone_val")
  #   }

  scope :order_by_id, -> {order(id: :asc)}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end



  private
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@gmail.com"
  end
end
