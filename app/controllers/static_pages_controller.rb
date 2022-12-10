class StaticPagesController < ApplicationController
  before_action :redirect_by_role, if: -> { current_user.present? }
  def home
    @products = Product.first(3)
    @featured_products = Product.order(price: :asc).first(10)
    @offer = Product.order(stock_quantity: :asc).first(2)
    @x = Product.all
  end

  def add_to_cart
    unless session["products"].present?
      item = CartItem.new(params[:product], 1)
      (session["products"] ||= []) <<  item
    else
      cart = session["products"]
      item = cart.find {|item| item["product_id"] == params[:product]}
      if item.present?
        item["quantity"] += 1
      else
        item = CartItem.new(params[:product], 1)
        cart <<  item
      end
      session["products"] = cart
    end
    redirect_back fallback_location: root_path
  end

  def remove_from_cart
    cart = session["products"]
    item = cart.find {|item| item["product_id"] == params[:product]}
    if item.present?
      item["quantity"] -= 1 if item["quantity"] > 1
    end
    session["products"] = cart

  redirect_back fallback_location: root_path
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
