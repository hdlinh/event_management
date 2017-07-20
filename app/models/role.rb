class Role < ApplicationRecord
  has_many :users
  validates :role_name, :role_description, presence: true

end
