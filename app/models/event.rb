class Event < ApplicationRecord
  #has_one :room, dependent: :destroy
  has_many :time_frames, dependent: :destroy
  has_many :speakers, through: :time_frames, dependent: :destroy


  validates :ev_name, :ev_description, :ev_date, presence: { message: I18n.t('event.invalid_val') }
end
