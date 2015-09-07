class GroupsController < ApplicationController
  before_action :require_login, only: [:index, :show, :create, :join, :leave]
  def index
  	@user = User.find(session[:user_id])
  	@groups = Group.all
  end

  def show
  	@group = Group.find(params[:id])
  	@members = Join.where(group_id: params[:id])
  end

  def create
  	group = Group.new(user_id: session[:user_id], name: params[:name], description: params[:description])
  	if group.save
  		flash[:errors] = ["New group created!"]
  		Join.create(user_id:session[:user_id], group_id:group.id)
  	else
  		flash[:errors] = group.errors.full_messages
  	end
  	redirect_to '/groups'
  end

  def destroy
  	group = Group.find(params[:id])
  	group.destroy
  	redirect_to '/groups'
  end

  def join
  	Join.create(user_id: session[:user_id], group_id: params[:id])
  	redirect_to "/groups/#{params[:id]}"
  end

  def leave
  	join = Join.find_by(user_id: session[:user_id], group_id: params[:id])
  	join.destroy
  	redirect_to "/groups/#{params[:id]}"
  end
end
