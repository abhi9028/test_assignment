class OrdersController < ApplicationController

  before_action :set_order, only: [:show, :edit, :update, :destroy]
    # GET /orders/new
  def new
    @order = current_order
    if @order.order_items.empty?
      redirect_to root_url, notice: "Your cart is empty"
    else
      respond_to do |format|
        format.html # new.html.erb format.xml { render :xml => @order }
      end
    end
  end

  # GET /orders/1/edit
  def edit
  end

  def thank_you
    @order = Order.find_by(id: params[:id])
  end

  def charge
    @order = current_order
    respond_to do |format|
      if @order.update(order_params) && @order.buy_with_stripe
        session.delete(:order_id)
        @order.update(status: 3)
        format.html { redirect_to(thank_you_order_path(@order), notice: 'Thank you for your order.') }
        format.xml { render xml: @order, status: :created, location: @order }
      else
        @order.update(status: 2)
        format.html { render action: 'new' }
        format.xml { render xml: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def thank_you
    @order = Order.find_by(id: params[:id])
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def shopping_bag
    @order = current_order
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :stripe_customer_token, :stripe_credit_card_id, :card_number, :cvv, :exp_month, :exp_year)
    end

end
