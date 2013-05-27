class MicropostsController < ApplicationController
  # http://ruby.railstutorial.org/chapters/user-microposts#code-sessions_helper_authenticate
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  # changed before_action to before_filter since error occured  
  # ERROR: ActionController::RoutingError (undefined method `before_action' for MicropostsController:Class):
  #app/controllers/microposts_controller.rb:3:in `<class:MicropostsController>'
  #app/controllers/microposts_controller.rb:1:in `<top (required)>'


  def index
    
  end

  def create
    # ERROR Encountered  can't convert Symbol into String 
    # app/controllers/microposts_controller.rb:39:in `micropost_params'
    # app/controllers/microposts_controller.rb:19:in `create'
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      # Ch 10 adding empty array feed_items http://ruby.railstutorial.org/chapters/user-microposts#code-microposts_create_action_with_feed
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end
  
  # Ch 10
  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    #  Ch 10 http://ruby.railstutorial.org/chapters/user-microposts#code-microposts_destroy_action
    def correct_user
      # This automatically ensures that we find only microposts belonging to the current user. In this case, we use find_by instead of find because the latter raises an exception when the micropost doesn’t exist instead of returning nil. By the way, if you’re comfortable with exceptions in Ruby, you could also write the correct_user filter like this:
      #@micropost = current_user.microposts.find_by(params[:id])  # ERROR: undefined method `find_by' for #<ActiveRecord::Relation:0x31f1e20>
      @micropost = current_user.microposts.find(params[:id])
      # redirect_to root_url if @micropost.nil?
      # OR 
      #  rescue   redirect_to root_url
      # Best way to do check current user is correct it the one below
      # To avoid this hack http://www.rubyfocus.biz/blog/2011/06/15/access_control_101_in_rails_and_the_citibank-hack.html
      redirect_to root_url unless current_user?(@micropost.user)
      # This would be equivalent to the code in Listing 10.46, but, as explained by Wolfram Arnold in the blog post Access Control 101 in Rails and the Citibank Hack, for security purposes it is a good practice always to run lookups through the association.
    end

end