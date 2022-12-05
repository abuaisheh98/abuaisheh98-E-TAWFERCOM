class StaticPagesController < ApplicationController
  def home
    @products = Product.first(3)
    @featured_products = Product.order(price: :asc).first(10)
    @offer = Product.order(stock_quantity: :asc).first(2)
  end



end
