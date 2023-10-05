class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_counter_post

  def self.five_recents_comments(post_id)
    Comment.where(post_id:).limit(5).order(created_at: :desc)
  end

  private

  def update_counter_post
    User.increment_counter(:posts_counter, author_id)
  end
end
