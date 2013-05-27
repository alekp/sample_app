class UsersController < ApplicationController
  # see private method signed_in_user below in the controller
  before_filter :signed_in_user, only: [:edit, :update]
  # Test for the correct user updating his profile
  before_filter :correct_user,   only: [:edit, :update]
  # Prevent Admin user from destroying himself 
  before_filter :admin_user,     only: :destroy
  
  
  def show
    @user = User.find(params[:id])  
    @page_title = 'User profile'
    # Ch 10
    @microposts = @user.microposts.paginate(page: params[:page])
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
      # sign in user
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"  # messaging
      redirect_to @user 
    else
      render 'new'
    end
  end
  
  # Ch 9 Manage Users
  def edit
    @page_title = 'Edit user'
    @user = User.find(params[:id])
  end
  
  def update
    @page_title = 'Update user'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a successful update.
      flash[:success] = "Profile updated"
      sign_in @user  # Important security step: http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-user_update_action
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  # /users   view all users 
  def index
    @page_title = 'All users'
    @users = User.paginate(page: params[:page]) # User.all  returns Array  PAginate returns Object of type ActiveRecord::Relation
  end
  
  # delete user 
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed. Why did u destroy him?"
    redirect_to users_url
  end
  
  
  
  # Ch 9 Authorization part
  private
    #http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-authorize_before_filter
    # def signed_in_user
      # store_location # Ch 9 Friendly forward part
      # redirect_to signin_url, notice: "Please sign in." unless signed_in?
    # end
    # NOTE: CH 10 Refactored moved in session_helper.rb
    
    # checks with before filter to see if current user corresponds to URI user ID param if not redirects to roo_path or home page
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    #http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-admin_destroy_before_filter
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
