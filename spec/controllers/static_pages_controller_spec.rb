require 'spec_helper'

describe StaticPagesController do
  # Added on the tutorial vide to render view before executing the tests
  render_views

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    # From the Video
   # it "should have selector / TAG with title and content" do
   #   get 'home'
   #   response.should have_selector("title",
      #response.should have_content('Simple App')
   #         :text => "Ruby On Rails Tutorial Sample App | Home" )
            #:match => "Ruby On Rails Tutorial Sample App | Home" )
   # end

    # from the Book online
    it "should have the content 'Sample App'" do
     visit '/static_pages/home'
     page.should have_content('Sample App')
      #get 'home'
      #response.should have_content('Sample App')
    end
    
        
end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    
    it "should have not-empty body tag" do
      get 'contact'
      response.body.should_not =~ /<body>\s*<\/body>/
    end
    
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

end
