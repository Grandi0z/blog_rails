class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :posts

  def self.update_counter_post(user_id)
    User.increment_counter(:posts_counter, user_id)
  end

  def self.five_recents_comments(post_id)
    Comment.where(post_id:).limit(5).order(created_at: :desc)
  end
end
