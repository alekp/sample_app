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

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  # Ch 10
  has_many :microposts, dependent: :destroy
  # Ch 11  Relationship  folowwed_users by the current_user
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  # (Listing 11.10), which explicitly tells Rails that the source of the followed_users array is the set of followed ids.
  has_many :followed_users, through: :relationships, source: :followed #  http://ruby.railstutorial.org/chapters/following-users#code-has_many_following_through_relationships
 
  #Ch 11 Reverse Relationship for folowers to the current_user http://ruby.railstutorial.org/chapters/following-users#code-user_reverse_relationships
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",# have to include Class name  because otherwise Rails would look for a ReverseRelationship class, which doesn’t exist.
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower 
  # It’s also worth noting that we could actually omit the :source key in this case, using simply
  # has_many :followers, through: :reverse_relationships
  

  before_save { |user| user.email = email.downcase }
  # http://ruby.railstutorial.org/chapters/sign-in-sign-out#code-sign_in_function
  before_save :create_remember_token

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  # Ch 10  http://ruby.railstutorial.org/chapters/user-microposts#code-proto_status_feed
  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end
  
  # Ch 11 http://ruby.railstutorial.org/chapters/following-users#code-following_p_follow_bang 
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  # http://ruby.railstutorial.org/chapters/following-users#code-user_unfollow
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  # http://stackoverflow.com/questions/5622054/undefined-method-salt
  private 
    def create_remember_token
       self.remember_token = SecureRandom.urlsafe_base64
    end
end
