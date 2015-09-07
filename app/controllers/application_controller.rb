class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def require_login
  	redirect_to '/mains' if session[:user_id] == nil
  end
  def current_user
  	User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  def joined_group group_id
  	Join.find_by(user_id: session[:user_id], group_id: group_id) if session[:user_id]
  end
  helper_method :joined_group
end
