class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:thank_you]

  def thank_you
    @order = current_user.success_orders.find_by(id: params[:id])
  end

  def shopping_bag
    @order = current_order
  end

end