class StaticPagesController < ApplicationController
  def home
    @page_title ='Home'
    # Ch 10 check if user signed in http://ruby.railstutorial.org/chapters/user-microposts#code-micropost_instance_variable
    # @micropost = current_user.microposts.build if signed_in?
    #  http://ruby.railstutorial.org/chapters/user-microposts#code-feed_instance_variable
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    
  end

  def contact
    @page_title ='Contact'
  end

  def about
    @page_title ='About Us'
  end
  
  def help
    @page_title = 'Help'
  end
end
