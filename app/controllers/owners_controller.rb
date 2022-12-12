class OwnersController < ApplicationController
  before_action :redirect_by_role
  before_action :get_data
  layout "dashboard"
  def index
  end


  private
  def get_data
    @orders = Order.all
    @my_orders = []
    @orders.each do |order|
      order.products.each do |product|
        if Store.find(product.store_id ).user_id == current_user.id
          @my_orders << order
        end
      end
    end
    @stores = current_user.stores
    @products = []
    @stores.each do |store|
      @products += store.products
     end
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
