require 'spec_helper'

describe "MicropostPages" do
  # describe "GET /micropost_pages" do
    # it "works! (now write some real specs)" do
      # # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      # get micropost_pages_index_path
      # response.status.should be(200)
    # end
  # end
  
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end
  
  # Ch 10  http://ruby.railstutorial.org/chapters/user-microposts#code-micropost_destroy_specs
  describe "micropost destruction" do
    #The application code is also analogous to the user case in Listing 9.47; the main difference is that, rather than using an admin_user before filter, in the case of microposts we have a correct_user before filter to check that the current user actually has a micropost with the given id. The code appears in Listing 10.46, and the result of destroying the second-most-recent post appears in Figure 10.17.
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end
  
  
  
  
end
