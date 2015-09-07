class MainsController < ApplicationController

  def index
  end

  def create
  	user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
  	if user.save
  		flash[:errors] = ["Successfully created a new user!"]
  	else
  		flash[:errors] = user.errors.full_messages
  	end
  	redirect_to '/mains'
  end

  def login
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to '/groups'
  	else
  		flash[:errors] = ["Invalid login, please try again."]
  		redirect_to '/mains'
  	end
  end

  def logout
  	session[:user_id] = nil
  	redirect_to '/mains'
  end
end
