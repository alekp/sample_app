require 'spec_helper'

describe "Static pages" do
  
  # Rails 3.2 http://ruby.railstutorial.org/chapters/static-pages#code-pages_controller_spec_title
  # main difference  page.should have_selector('....

  describe "Home page" do

    it "should have the h1 'Sample App'" do
      #visit '/static_pages/home'
      visit root_path
      page.should have_selector('h1', :text => 'Sample App')
    end

    it "should have the title 'Home'" do
      #visit '/static_pages/home'
      visit root_path
      page.should have_selector('title',
                        :text => "Ruby on Rails Tutorial Sample App | Home")
    end
  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      #visit '/static_pages/help'
      visit help_path
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the title 'Help'" do
      #visit '/static_pages/help'
      visit help_path
      page.should have_selector('title',
                        :text => "Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About Us'" do
      #visit '/static_pages/about'
      visit about_path
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have the title 'About Us'" do
      #visit '/static_pages/about'
      visit about_path
      page.should have_selector('title',
                    :text => "Ruby on Rails Tutorial Sample App | About Us")
    end
  end
end