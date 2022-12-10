class CartsController < ApplicationController
  before_action :redirect_by_role, if: -> { current_user.present? }
  def index
    iteration = 0
    if session["products"].nil?
      redirect_to controller: :static_pages, action: :home
    else
      [session["products"]].each do |product|
        products = Product.find(product[iteration]["product"])
        @quantity = product[iteration]["quantity"]
        (@cart ||= []) << products
        iteration += 1
      end
    end
    total_price
  end

  def total_price
    @total = 0.0
    if session["products"].present?
      session["products"].each do |product_id|
        product = Product.find(product_id["product"])
        @total += product.price
      end
    end
  end

  def checkout
    if current_user.present?
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  # def set_quantity_and_price
  #   if session["products"].present?
  #     params[:quantity] += 1
  #     @quantity = params[:quantity]
  #     session["products"].each do |product_id|
  #       product = Product.find(product_id)
  #       @total_price_for_product = product.price * params[:quantity]
  #     end
  #   end
  # end

  private
  def redirect_by_role
      if current_user.role == "admin"
        redirect_to controller: :admins, action: :index
      elsif current_user.role == "owner"
        redirect_to controller: :owners, action: :index
      end
  end

end
