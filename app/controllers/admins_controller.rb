class AdminsController < ApplicationController
  before_action :user_params
  before_action :get_users_data, only: [:index]
  before_action :check_session
  before_action :redirect_by_role, if: -> { current_user.role != 'Admin' }
  layout 'dashboard'

  def index
  end

  private
  def get_users_data
    @admins = User.where('role = 2')
    @owners = User.where('role = 1')
    @costumers = User.where('role = 0')
  end

  def redirect_by_role
    if current_user.present?
      # if current_user.role == "admin"
      #   redirect_to action: :index
      if current_user.role == "owner"
        redirect_to controller: :owners, action: :index
      else
        redirect_to controller: :static_pages, action: :home
      end
    else
      redirect_to controller: :static_pages, action: :home
    end
  end

  def check_session
    (redirect_to controller: :static_pages, action: :home )unless current_user.present?
  end

  def user_params
    params.permit(:name, :email, :password, :role)
  end
end
