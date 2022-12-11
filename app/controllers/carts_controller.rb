class CartsController < ApplicationController
  before_action :redirect_by_role, if: -> { current_user.present? }
  def index
    item_view = Struct.new(:product, :quantity)
    unless session["products"].present?
      redirect_to controller: :static_pages, action: :home
    else
      @cart = []
      @sub_total = 0
        session["products"].each do |item|
          instance = item_view.new(Product.find(item["product_id"]),item["quantity"])
          @sub_total += instance["product"].price * instance["quantity"]
          @cart << instance
          session["checkout"] = @cart
        end
    end
  end

  def checkout
    if current_user.present?
      if current_user.role == 'customer'
        order = Order.new
        order.status = "paid"
        order.quantity = 0
        session["checkout"].each do |item|
          order.quantity += item["quantity"]
        end
        order.order_date = Date.today
        order.user_id = current_user.id
        order.save!
        session["checkout"] = nil
        redirect_to controller: :static_pages, action: :home
      end
    else
      redirect_to new_user_session_path
    end
  end

  private
  def redirect_by_role
      if current_user.role == "admin"
        redirect_to controller: :admins, action: :index
      elsif current_user.role == "owner"
        redirect_to controller: :owners, action: :index
      end
  end

end
