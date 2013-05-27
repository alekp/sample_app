class Micropost < ActiveRecord::Base
  # was not in the book attr_accessible 
  attr_accessible :content, :user_id
  
  #Ch 10
  belongs_to :user 
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140}
  validates :user_id, presence: true  
  
end
