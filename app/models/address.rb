class Address < ApplicationRecord
  belongs_to :user
  validates :address, presence: true, length: { minimum: 25 }
end
