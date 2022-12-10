class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_categories_data
  layout :layout_by_resource
  before_action :session_expiry
  before_action :update_activity_time

  def after_sign_in_path_for(resource)
    if current_user.role == 'owner'
      carts_index_path
    else
      root_path
    end
  end

  def session_expiry
    if session[:expires_at].present?
      if session[:expires_at].to_time < Time.now
        flash.now[:error] = "Your session has timed out. Please log back in."
        session["products"] = nil
      end
    end
  end

  def update_activity_time
    session[:expires_at] = Time.now + 1.minutes
  end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    end

    private

    def get_categories_data
      @categories = Category.all
    end

    def layout_by_resource
      # if devise_controller?
      #   'devise_layout'
      # else
      #   'application'
      # end
      if current_user.present?
        (current_user.role == 'admin' or current_user.role == 'owner') ? 'dashboard' : 'application'
      else
        'application'
      end
    end
  end
