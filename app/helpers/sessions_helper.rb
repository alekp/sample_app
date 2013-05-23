module SessionsHelper
  
 def sign_in(user)
    # cookies.permanent.signed[:remember_token] = [user.id, user.salt] # not working no salt method found
    #fix http://ruby.railstutorial.org/chapters/sign-in-sign-out#sec-a_working_sign_in_method
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
    #@current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_user.nil? # had issues while i was changing it to  !@current_user.nil? did not find current user
  end

  def sign_out
    self.current_user = nil
    #@current_user = nil
    cookies.delete(:remember_token)
  end

   def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == @current_user
  end

  #http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-friendly_forwarding_test
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
  

end
