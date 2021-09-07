class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :menu_item
  def self.cart_total(user_id)
    of_user(user_id).sum("price * quantity")
  end

  def self.of_user(user_id)
    all.where(user_id: user_id)
  end
end
