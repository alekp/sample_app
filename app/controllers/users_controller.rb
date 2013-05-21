class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])  
    @page_title = 'User profile'
  end
  
  def new
    @page_title = 'Sign up'
    @user = User.new
  end
  
  def create
    @page_title = 'Sign up'
    @user = User.new(params[:user])
    if @user.save      
      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"  
      redirect_to @user 
    else
      render 'new'
    end
  end
end
