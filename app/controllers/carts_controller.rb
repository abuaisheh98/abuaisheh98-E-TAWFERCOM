class CartsController < ApplicationController
  before_action :redirect_by_role, if: -> { current_user.present? }
  def index
    item_view = Struct.new(:product, :quantity)
    if session["products"].nil?
      redirect_to controller: :static_pages, action: :home
    else
      @cart = []
        session["products"].each do |item|
          instance = item_view.new(Product.find(item["product_id"]),item["quantity"])
          @cart << instance
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

  private
  def redirect_by_role
      if current_user.role == "admin"
        redirect_to controller: :admins, action: :index
      elsif current_user.role == "owner"
        redirect_to controller: :owners, action: :index
      end
  end

end
