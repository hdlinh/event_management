class TimeFrame < ApplicationRecord
  belongs_to :room, required: false
  belongs_to :event, required: false
  belongs_to :speaker, required: false

  validates :tf_title, :tf_start, :tf_end, :sp_id, :ev_id, :ro_id, presence: true
end
