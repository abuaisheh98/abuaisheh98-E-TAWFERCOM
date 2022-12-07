class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_categories_data
  layout :layout_by_resource
  # before_action :update_session_time, except:  [:home]
  # before_action :session_expires, except:  [:index]



  def session_expires
    @time_left = session[:expires_at]
    puts @time_left.to_i
    puts Time.now.to_i
    unless @time_left.to_i > Time.now.to_i
      reset_session
      flash[:error] = "time left"
      session.destroy
      redirect_to :controller => :static_pages, :action => :home
    end
  end

  def update_session_time
    session[:expires_at] = Time.now + 1.minutes
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private
  def get_categories_data
    @categories = Category.all
  end

  def layout_by_resource
    if devise_controller?
      'devise_layout'
    else
      'application'
    end
  end
end
