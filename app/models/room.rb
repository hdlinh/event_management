class Room < ApplicationRecord
  has_many :time_frames, dependent: :destroy

  validates :ro_name, presence: true, length: {
    minimum: Settings.room.min_name_length,
    maximum: Settings.room.max_name_length
  }
  validates :ro_type, presence: true, length: {
    maximum: Settings.room.max_type_length
  }
end
