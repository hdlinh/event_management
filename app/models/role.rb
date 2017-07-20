class Role < ApplicationRecord
  belongs_to :user
  validates :role_name, :role_description, presence: true

end
