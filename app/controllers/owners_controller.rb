class OwnersController < ApplicationController
  before_action :redirect_by_role
  before_action :get_data
  layout "dashboard"
  def index
    respond_to do |format|
      format.html
      format.json {render json: OrderDatatable.new(params, {current_user: current_user.id})}
    end
  end


  private
  def get_data
    @stores = current_user.stores
    @products = @stores.map{|store| store.products}.flatten
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
