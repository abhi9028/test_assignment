class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, :order_id, :unit_price, presence: true
  delegate :name, :description, to: :product
  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total_price
    unit_price * quantity
  end

  private

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end

end
