class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item
  attr_accessible :order_id, :menu_item_name, :menu_item_id, :price, :quantity
end
