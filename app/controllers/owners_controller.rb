class OwnersController < ApplicationController
  before_action :get_data
  layout "dashboard"
  def index
  end


  private
  def get_data
    @orders = Order.all
    @stores = Store.all
    @product = Product.all
  end
end
