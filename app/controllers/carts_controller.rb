class CartsController < ApplicationController
  before_action :redirect_by_role
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

  private
  def redirect_by_role
    if current_user.present?
      if current_user.role == "admin"
        redirect_to controller: :admins, action: :index
      elsif current_user.role == "owner"
        redirect_to controller: :owners, action: :index
      else
        redirect_to action: :index
      end
    else
      (session["products"].nil?) ? (redirect_to controller: :static_pages, action: :home) : (redirect_to action: :index)
    end

  end

end
