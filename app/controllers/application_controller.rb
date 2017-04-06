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
      order = Order.new()
      order.save(validate: false)
      session[:order_id] = order.id
      return order
    end
  end

  def lastpendingorder
    Order.in_progress.last
  end

end
