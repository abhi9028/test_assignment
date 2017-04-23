class CheckoutController < ApplicationController
  load_and_authorize_resource class: Order
  before_action :authenticate_user!

  def index
    @order = current_order
    if @order.order_items.empty?
      redirect_to root_path, notice: "Your cart is empty"
    end
  end

  def charge
    @order = current_order
    respond_to do |format|
      if @order.update(order_params) && @order.buy_with_stripe
        purchase = current_user.purchases.create(order: @order, total_cost: @order.total_price)
        @order.update(status: 3)
        session.delete(:order_id)
        format.html { redirect_to(thank_you_order_path(@order), notice: 'Thank you for your order.') }
        format.xml { render xml: @order, status: :created, location: @order }
      else
        @order.update(status: 2)
        format.html { redirect_to(checkout_index_path, notice: 'Please try again.') }
        format.xml { render xml: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:stripe_customer_token, :stripe_credit_card_id, :card_number, :cvv, :exp_month, :exp_year, address_attributes: [:name, :line_1, :city, :email])
  end

end
