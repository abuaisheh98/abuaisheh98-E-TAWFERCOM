class AdminsController < ApplicationController
  before_action :get_users_data, only: [:index]
  before_action :redirect_by_role
  layout 'dashboard'
  def index
  end

  private
  def get_users_data
    @admins = User.where('role = 2')
    @owners = User.find_by_role('owner')
    @costumers = User.find_by_role('costumer')
  end

  def redirect_by_role
    if current_user.present?
      if current_user.role == "admin"
        redirect_to action: :index
      elsif current_user.role == "owner"
        redirect_to controller: :owners, action: :index
      else
        redirect_to controller: :static_pages, action: :home
      end
    else
      redirect_to controller: :static_pages, action: :home
    end
  end
end
