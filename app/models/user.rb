class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  def self.three_recent_posts(author_id)
    Post.where(author: author_id).limit(3).order(created_at: :desc)
  end
end
