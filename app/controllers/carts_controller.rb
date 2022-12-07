class CartsController < ApplicationController
  def index

    unless session["products"].nil?
      session["products"].each do |product_id|
        products = Product.find(product_id)
        (@cart ||= []) << products
      end
    else
      redirect_to controller: :static_pages, action: :home
    end
  end

end
