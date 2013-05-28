require 'spec_helper'

describe "Static pages" do
  
   subject { page }
  
   # Ch 10    http://ruby.railstutorial.org/chapters/user-microposts#code-home_page_feed_test
   describe "Home page" do

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          # Listing 10.37 assumes that each feed item has a unique CSS id, so that
          # will generate a match for each item. 
          # (Note that the first # in li##{item.id} is Capybara syntax for a CSS id, 
          # whereas the second # is the beginning of a Ruby string interpolation #{}.)
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end
  

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    #page.should have_selector 'title', text: full_title('About Us')
    expect(page).to have_selector 'title', text: full_title('About Us')
    click_link "Help"
    #page.should have_selector  'title', text: full_title('Help')
    expect(page).to have_selector  'title', text: full_title('Help')
    click_link "Contact"
    #page.should have_selector  'title', text: full_title('Contact')
    expect(page).to have_selector  'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    #page.should have_selector  'title', text: full_title('Sign up')
    expect(page).to have_selector  'title', text: full_title('Sign up')
    click_link "sample app"
    #page.should have_selector  'title', text: full_title('Home')
    expect(page).to have_selector  'title', text: full_title('Home')
  end
end