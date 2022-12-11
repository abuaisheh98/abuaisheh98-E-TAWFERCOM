class AdminsController < ApplicationController
  before_action :user_params
  before_action :get_users_data, only: [:index]
  before_action :check_session
  before_action :redirect_by_role, if: -> { current_user.role != 'admin' }
  layout 'dashboard'

  def index
  end

  def display_categories
  end

  def display_stores
    @stores = Store.all
  end

  def new_user
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    parameters = params.require(:user).permit(:id, :email, :name, :password, :password_confirmation, :role)
    @user = User.find(parameters['id'].to_i)
    @user.update!(parameters)
    redirect_to root_path
  end

  def products_by_categories
    @products_by_category = (Category.find(params[:id])).products
  end

  def products_by_stores
    @products_by_store = (Store.find(params[:id])).products
  end

  def create_user
    @user = User.new(user_params)
    @user.save
    redirect_to action: :index
  end

  def show_user
  end

  private
  def get_users_data
    @admins = User.where('role = 2')
    @owners = User.where('role = 1')
    @costumers = User.where('role = 0')
  end

  def redirect_by_role
    if current_user.present?
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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end
end
