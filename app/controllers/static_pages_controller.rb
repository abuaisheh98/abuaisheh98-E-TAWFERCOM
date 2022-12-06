class StaticPagesController < ApplicationController
  def home
    @products = Product.first(3)
    @featured_products = Product.order(price: :asc).first(10)
    @offer = Product.order(stock_quantity: :asc).first(2)
    @x = Product.all
  end

  def add_to_cart
    (session["products"] ||= []) << params[:product]
    redirect_to controller: :static_pages,action: :home
  end



end
