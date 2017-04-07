class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  helper_method :current_order

  def current_order
    # session.clear
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      lastpendingcustomerorder || Order.new(user: current_user)
    end
  end

  def after_sign_in_path_for(resource)
    if session[:order_id].present?
      # order = Order.find(session[:order_id])
      if current_order.user_id.nil?
        current_order.update(user: current_user)
        session.delete(:order_id)
      end
      if current_user.cart.present? && current_user.cart.order_items.present?
        order_items = current_order.order_items
        current_user.cart.order_items << order_items
        if current_user.cart.save
          porder = Order.in_progress.by_customer(current_user)
          porder.last.destroy if porder.count > 1
          session.delete(:order_id)
        end
      end
    end
    super
  end

  private

  def lastpendingcustomerorder
    Order.in_progress.by_customer(current_user).last
  end

end
