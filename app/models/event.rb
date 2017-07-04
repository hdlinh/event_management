class Event < ApplicationRecord
  #has_one :room, dependent: :destroy
  has_one :time_frame, dependent: :destroy

  validates :ev_name, :ev_description, :ev_date, presence: { message: I18n.t('event.invalid_val') }
end
