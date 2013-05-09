require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    # From the Video
    # it "should do something" do
    #  get 'home'
    #  response.should have_content('title',
    #        :content => "Ruby On Rails Tutorila Sample App | Home" )
    #end

    # from the Book online
     it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      #get 'home'
      page.should have_content('Sample App')
    end
    
end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

end
