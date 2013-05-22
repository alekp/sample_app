class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper # Chapter 8 Sign in out include session helper 
  #there should be an "include SessionsHelper" in the application controller. 
  #By default, helpers are included in the views but in order to make use of a helper in a controller, 
  #it needs to be included explicitly.
  
  #http://ruby.railstutorial.org/chapters/sign-in-sign-out#code-sessions_helper_include
  
   # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end
