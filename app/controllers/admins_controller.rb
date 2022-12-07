class AdminsController < ApplicationController
  before_action :get_users_data, only: [:index]
  layout 'dashboard'
  def index
  end

  private
  def get_users_data
    @admins = User.where('role = 2')
    @owners = User.find_by_role('owner')
    @costumers = User.find_by_role('costumer')
  end
end
