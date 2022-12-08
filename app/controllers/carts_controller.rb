class CartsController < ApplicationController
  def index
    if session["products"].nil?
      redirect_to controller: :static_pages, action: :home
    else
      session["products"].each do |product_id|
        products = Product.find(product_id)
        (@cart ||= []) << products
      end
    end
  end

  # def empty_cart
  #   session["products"] = nil
  #   redirect_to controller: :static_pages, action: :home
  # end

end
