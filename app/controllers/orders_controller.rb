class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:thank_you]

  def thank_you
    authorize! :thank_you, Order
    @order = current_user.success_orders.find_by(id: params[:id])
  end

  def shopping_bag
    authorize! :shopping_bag, Order if user_signed_in?
    @order = current_order
  end

end