class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end
  
  helper_method :current_user1
  
   protected 
   def current_user1
     @current_user1 ||= Moviegoer.find_by_id(session[:user_id]) if session[:user_id]
     # unless @current_user
  #      render 'sessions/login'   
  #      return
  #    end
    # ((redirect_to login_path) and (return)) unless @current_user
   end
  

end
