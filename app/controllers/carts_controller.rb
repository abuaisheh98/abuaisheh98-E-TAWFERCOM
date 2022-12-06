class CartsController < ApplicationController
  def index

    session["products"].each do |product_id|
      products = Product.find(product_id)
      (@cart ||= []) << products

    end
    puts @cart
  end

end
