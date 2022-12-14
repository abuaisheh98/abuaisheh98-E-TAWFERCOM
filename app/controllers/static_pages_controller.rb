class StaticPagesController < ApplicationController
  before_action :redirect_by_role, if: -> { current_user.present? }
  def home
    @products = Product.first(3)
    @featured_products = Product.low_price.order(price: :asc).first(12)
    @offer = Product.order(stock_quantity: :asc).first(2)
    @low_price = Product.low_price
    @high_price = Product.high_price
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

  def search
    if params[:search].blank?
      redirect_to action: :home
    else
      @result = Product.by_name(params[:search].downcase)[0]
    end
  end

  def products_by_category
    @category_name = Category.find(params[:id]).name
    @products_by_category = (Category.find(params[:id])).products
  end

  def display_store
    @stores = Store.all
  end

  def products_by_stores
    @store_name = Store.find(params[:id]).name
    @products_by_store = (Store.find(params[:id])).products
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
