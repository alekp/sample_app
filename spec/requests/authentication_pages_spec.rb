require 'spec_helper'

describe "AuthenticationPages" do
  # describe "GET /authentication_pages" do
    # it "works! (now write some real specs)" do
      # # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      # get authentication_pages_index_path
      # response.status.should be(200)
    # end
  # end
  
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end
  
  # test singin with invalid credentials
  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      #it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      it { should have_error_message('Invalid') } # http://ruby.railstutorial.org/chapters/sign-in-sign-out#sec-rspec_custom_matchers
      
      #http://ruby.railstutorial.org/chapters/sign-in-sign-out#code-correct_signin_failure_test
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
      
    end
    
    # test for successful valid information
   describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      # before do
        # fill_in "Email",    with: user.email.upcase
        # fill_in "Password", with: user.password
        # click_button "Sign in"
      # end
      before { valid_signin(user) }
      # http://ruby.railstutorial.org/chapters/sign-in-sign-out#code-have_error_message

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Users',    href: users_path) } # ch 9 adding index page
      it { should have_link('Settings', href: edit_user_path(user)) } # Ch 9 http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-settings_link_test
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
      
    end    
  end
  
  
  # http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-protected_edit_update_tests
  # IMPORTANT PART Authorization and TESTING features
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
        
        # check index action/page for users  view all /users 
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('title', text: 'Sign in') }
        end
        
      end
      
      # Ch 10  http://ruby.railstutorial.org/chapters/user-microposts#code-micropost_access_control
      describe "in the Microposts controller" do

        describe "submitting to the create action" do
          before { post microposts_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
      
    end
    
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_path) }        
      end
    end
    
    
  end
  
   
end
