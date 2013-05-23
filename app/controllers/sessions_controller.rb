class SessionsController < ApplicationController
  def new
    @page_title = 'Sign in'
  end

  def create
    @page_title = ''
    
    # check if user exist in DB    
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in user   # use existing rails authentication  sing_in method
      #redirect_to user  # redirects to user profile page  user/show.html.erb
      #  redirect_back_or changed in Ch 9 http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-friendly_session_create
      redirect_back_or user  # rhttp://stackoverflow.com/questions/14802851/ror-chapter-8-section-8-2-4-undefined-method-for-signin
    else
      # Create an error message and re-render the signin form.
      flash.now[:error] = 'Invalid email/password combination' # Not quite right! with >>> flash[:error] <<< see Ch 8 Listing 8.12. and before
      render 'new'
    end
      
    # http://stackoverflow.com/questions/8038716/ruby-on-rails-stuck-on-chapter-9-3-3-of-hartl-book-undefined-method-sign-in
      # user = User.authenticate( params[:session][:email].downcase,
                                # params[:session][:password])
     # if user.nil?
       # flash.now[:error] = "Invalid email/password combo."
       # @title = "Sign in"
       # render 'new'
     # else
       # sign_in user
       # redirect_to user
     # end 
      
  end

  def destroy
    @page_title = ''# only rails not to ask for page_title
    sign_out
    redirect_to root_url
  end
end
