require 'spec_helper'

describe "Static pages" do

  # Rails 4.0 http://ruby.railstutorial.org/chapters/static-pages?version=4.0#code-pages_controller_spec_title
  # main difference  expect(page).to have_content('....     
  # xpect(page).to have_selector( )

  subject { page }

  describe "Home page" do

    it "should have the content 'Sample App'" do
      #visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "should have the title 'Home'" do
      #visit '/static_pages/home'
      visit root_path
      #expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")  # Rails 4.0 
      expect(page).to have_selector('title',
                                    :text => "Ruby on Rails Tutorial Sample App | Home") # rails 3.2 adoption
      
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      #visit '/static_pages/help'
      visit help_path
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      #visit '/static_pages/help'
      visit help_path
      #expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
      expect(page).to have_selector('title',
                                    :text => "Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      #visit '/static_pages/about'
      visit about_path
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      #visit '/static_pages/about'
      visit about_path
      #expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
      expect(page).to have_selector('title',
                                    :text => "Ruby on Rails Tutorial Sample App | About Us")
    end
  end
end