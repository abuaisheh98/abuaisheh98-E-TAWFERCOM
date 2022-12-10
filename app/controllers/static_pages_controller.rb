class StaticPagesController < ApplicationController
  def home
    @products = Product.first(3)
    @featured_products = Product.order(price: :asc).first(10)
    @offer = Product.order(stock_quantity: :asc).first(2)
    @x = Product.all
  end

  def add_to_cart
    if session["products"].present?
      cart_item = CartItem.new(params[:product],1)
      item = cart_item.generate_hash
      temporary_array = [session["products"]]
      index = 0
      temporary_array.each do |item_in_session|
        if item_in_session[index]["product"] == item["product"]
          item_in_session[index]["quantity"] += 1
          session["products"][index]["quantity"]=item_in_session[index]["quantity"] += 1
          index += 1
          break
        else
          (session["products"] ||= []) << item
          break
        end
      end
    else
      cart_item = CartItem.new(params[:product],1)
      item = cart_item.generate_hash
      (session["products"] ||= []) << item
    end

    # (session["products"] ||= []) << params[:product]
    redirect_to controller: :static_pages,action: :home
  end



end
