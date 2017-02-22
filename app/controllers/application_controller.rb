class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_login
    if session[:user_id] and User.find(session[:user_id])
      yield
    else
      redirect_to login_url
    end
  end

  def require_no_login
    if session[:user_id] and User.find(session[:user_id])
      redirect_to show_user_url
    else
      yield
    end
  end
end
