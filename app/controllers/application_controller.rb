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
    if session[:order_id].present? && user_signed_in?
      order = Order.find(session[:order_id])
      if order.user_id.nil?
        order.update(user: current_user)
      else
        # order
      end
    end
    super
  end

  private

  def lastpendingcustomerorder
    Order.in_progress.by_customer(current_user).last
  end

end
