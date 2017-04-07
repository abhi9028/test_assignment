class OrderItemsController < ApplicationController

  def create
    order = current_order
    order_item = order.add_product(order_item_params[:product_id])
    # order_item = order.order_items.new(order_item_params)
    if order.save(validate: false)
      session[:order_id] = order.id
      render js: "window.location = '/'"
      flash[:success] = "Product added in your cart page!"
    end
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    if @order_item.destroy
      redirect_to shopping_bag_path, notice: "Order Item Successfully remove"
      # @order_items = @order.order_items
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id)
  end

end
