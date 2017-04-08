class Order < ActiveRecord::Base
  
  attr_accessor :cvv, :card_number, :stripe_customer_token, :exp_month, :exp_year, :stripe_credit_card_id

  belongs_to :user
  has_one :address, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_one :purchase, dependent: :destroy
  delegate :email, :line_1, :city, :name, to: :address, allow_nil: true
  accepts_nested_attributes_for :address, allow_destroy: true

  IN_PROGRESS = 0
  PLACED = 1
  CANCELLED = 2
  PAID = 3

  enum status: { inprogress: IN_PROGRESS, placed: PLACED, cancelled: CANCELLED, paid: PAID }
  scope :by_customer, ->(user) { where(user: user) }
  scope :in_progress, -> { where(status: IN_PROGRESS) }

  def total_price
    order_items.to_a.sum { |item| item.total_price }
  end

  def add_product(product_id)
    current_item = order_items.where(product_id: product_id).first
    if current_item
      current_item.quantity += 1
      current_item.save
    else
      current_item = order_items.build(product_id: product_id, quantity: 1)
    end
      current_item
  end

  def buy_with_stripe
    if self.valid?
      begin
        customer = Stripe::Customer.create(
          :email => self.email,
          :source  => self.stripe_customer_token
        )
        self.user.stripe_id = customer.id
        self.user.save

        charge = Stripe::Charge.create(
          customer: customer.id,
          amount: ((total_price) * 100).to_i,
          description: "#{self.email} Stripe customer",
          currency: 'usd'
        )
      rescue Stripe::CardError => e
        errors.add(:base , e.message)
        false
      end
    end
  end

end