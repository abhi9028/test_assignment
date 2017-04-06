class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :cart, -> { where(status: 0) }, class_name: "Order"
  has_many :orders, -> { where(status: 3) }, dependent: :destroy
  has_many :purchases

end
