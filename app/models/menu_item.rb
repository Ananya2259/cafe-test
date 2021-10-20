class MenuItem < ApplicationRecord
  belongs_to :menu_category
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }
  validates :description, length: { minimum: 3 }
  attr_accessible :menu_category_id, :name, :description, :price
end
