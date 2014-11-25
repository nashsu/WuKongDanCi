class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_if_login

    if session[:user_id]
      return true
    else
      redirect_to login_path
    end
    
  end


end
