class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  validates :product_id, :order_id, :unit_price, presence: true

  delegate :name, :description, to: :product

  def order_item_price
    product.price * quantity
  end

end
