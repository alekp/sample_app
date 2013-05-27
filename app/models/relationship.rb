class Relationship < ActiveRecord::Base
  # attr_accessible not in the book
  attr_accessible :followed_id, :follower_id
  # Ch 11 http://ruby.railstutorial.org/chapters/following-users#code-relationship_belongs_to
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
