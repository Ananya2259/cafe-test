class User < ActiveRecord::Base
  attr_accessible :password,:email,:role,:name
  # wrap_parameters :user, include: [:name, :password,:email,:role]
  # attr_accessor :password, :email,:role,:name
  validates :name, presence: true, length: { minimum: 4 }
  validates :email, { presence: true, uniqueness: true }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password
  has_many :cart_items, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :orders, :dependent => :destroy

  def to_user_details
    " Email:#{email} Name:#{name}"
  end

  def user?
   role == "user"
  end
end
