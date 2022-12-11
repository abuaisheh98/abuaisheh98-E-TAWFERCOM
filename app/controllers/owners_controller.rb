class OwnersController < ApplicationController
  before_action :redirect_by_role
  before_action :get_data
  layout "dashboard"
  def index
  end


  private
  def get_data
    @orders = Order.all
    @products_in_order =
    @stores = Store.find_by_user_id(current_user.id)
    @products = (Store.find_by_user_id(current_user.id)).products
  end

  def redirect_by_role
    if current_user.present?
      if current_user.role == "admin"
        redirect_to controller: :admins, action: :index
      elsif current_user.role == "customer"
        redirect_to controller: :static_pages, action: :home
      end
    else
      redirect_to controller: :static_pages, action: :home
    end
  end
end
