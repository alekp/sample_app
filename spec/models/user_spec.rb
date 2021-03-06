# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User", email: "user@example.com", 
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  # Ch 8 addition sign in out 8.2.1 Remember me
  it { should respond_to(:remember_token) }
  
  # Ch 0 admin chech for user delete
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  
  # Ch 10 Microposts
  it { should respond_to(:microposts) }
  it { should respond_to(:feed) }
  
  # Ch 11 
  it { should respond_to(:relationships) }
  it { should respond_to(:followed_users) }
  # Ch 11  http://ruby.railstutorial.org/chapters/following-users#code-utility_method_tests
  it { should respond_to(:followed_users) }  
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  # Ch 11  http://ruby.railstutorial.org/chapters/following-users#fig-user_has_many_followers
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  it { should be_valid } # same as in IRC console  user.valid?  or test @user. should be_valid

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  # lenght validate
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  #FORMAT VALIDATE
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end
  
  # User Duplication check
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
 # Duplicate already taken email address test
 describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  # test to check empty password fields entry
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
 
  # Check pass and confirmation for missmatch since  it { should be_valid } above cheks for a MATCH
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  # check confirmation if Nil this should not happen throu Web. might happen from console
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  
  # Authenticate user password check test cases
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
  # Validate password length 
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  # Ch 8 Remember ME test for token 
  #http://ruby.railstutorial.org/chapters/sign-in-sign-out#code-remember_token_should_not_be_blank
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  # Ch 10 
  describe "micropost associations" do
    # http://ruby.railstutorial.org/chapters/user-microposts#code-micropost_ordering_test
    before { @user.save }
    let!(:older_micropost) do 
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
    end
    
    #  http://ruby.railstutorial.org/chapters/user-microposts#code-micropost_dependency_test
    it "should destroy associated microposts" do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      # Test with where method call insead of find 
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end
      # same as above test but with find method 
      # expect do 
        # Micropost.find(micropost)
      # end.to raise_error(ActiveRecord::RecordNotFound)
      
    end
    
    # Ch 10 http://ruby.railstutorial.org/chapters/user-microposts#code-feed_specs
    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_micropost) }
      its(:feed) { should include(older_micropost) }
      its(:feed) { should_not include(unfollowed_post) }
    end    
  end # end micrposts
  
  # ch 11  http://ruby.railstutorial.org/chapters/following-users#code-utility_method_tests
  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }    
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }
  
   
    # Ch 11  http://ruby.railstutorial.org/chapters/following-users#fig-user_has_many_followers
    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(@user) }
    end
    
    
    describe "and unfollowing" do
      before { @user.unfollow!(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
 
    
  end

end
