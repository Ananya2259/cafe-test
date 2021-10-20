class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  attr_accessible :user_id,:address,:status,:archive

  def self.order_display(user_id)
    user = User.find(user_id)
    if user.role == "Admin" || user.role == "clerk"
      Order.all
    else
      user.orders
    end
  end

  def self.daterange(from, to, month, user_id)
    if from == nil && to == nil
      self.order_display(user_id).where("extract(month from created_at) = ?", month)
    else
      self.order_display(user_id).where("created_at::date >= ? and created_at::date <= ?", from, to)
    end
  end
end
