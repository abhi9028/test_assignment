class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :cart, -> { where(status: 0) }, class_name: "Order", dependent: :destroy
  has_many :success_orders, -> { where(status: 3) }, class_name: "Order", dependent: :destroy
  has_many :failed_orders, -> { where(status: 2) }, class_name: "Order", dependent: :destroy
  has_many :purchases

  BUYER = 0
  ADMIN = 1
  enum role: { buyer: BUYER, admin: ADMIN }

end
