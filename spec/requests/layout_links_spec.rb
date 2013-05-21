require 'spec_helper'

# NOTE: this is integration test generated wiht 
# rails generate integrations_test layout_links

describe "LayoutLinks" do
  # describe "GET /layout_links" do
    # it "works! (now write some real specs)" do
      # # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      # get layout_links_index_path
      # response.status.should be(200)
    # end
  # end
  
  
  # Manualy added test integration cases 
  describe "Contact page" do

    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: 'Contact')
    end

    it "should have the title 'Contact'" do
      visit '/static_pages/contact' # OR contact_path defined in routes.rb    get "static_pages/contact"
      page.should have_selector('title',
                    text: "Ruby on Rails Tutorial Sample App | Contact")
    end
  end
  
  
    describe "Home page" do

    it "should have the h1 'Sample App'" do
      visit root_path
      page.should have_selector('h1', text: 'Sample App')
    end

    it "should have the base title" do
      visit root_path  # OR '/' for root_path
      page.should have_selector('title',
                        text: "Ruby on Rails Tutorial Sample App")
    end

    it "should not have a custom page title" do
      visit root_path
      page.should_not have_selector('title', text: '| Home')
    end
  end
  
  # the same test from above only with subject OBJ for use in Test cases should methods can be called on page
  describe "Home page with subject" do
    before { visit root_path } 

    it { should have_selector('h1', text: 'Sample App') }
    it { should have_selector 'title',
                        text: "Ruby on Rails Tutorial Sample App" }
    it { should_not have_selector 'title', text: '| Home' }
  end
  

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit help_path  # or 'static_pages/help' directr non Ruby on Rails link to page
      page.should have_selector('h1', text: 'Help')
    end

    it "should have the title 'Help'" do
      visit help_path
      page.should have_selector('title',
                        text: "Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About'" do
      visit about_path
      page.should have_selector('h1', text: 'About Us')
    end

    it "should have the title 'About Us'" do
      visit about_path
      page.should have_selector('title',
                    text: "Ruby on Rails Tutorial Sample App | About Us")
    end
  end

  describe "Contact page" do

    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: 'Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title',
                    text: "Ruby on Rails Tutorial Sample App | Contact")
    end
  end
  
  
  
end
