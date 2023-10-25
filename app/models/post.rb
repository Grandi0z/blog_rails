class Post < ApplicationRecord
  validates :title, presence: true, length: { in: 2..250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_counter_post

  def five_recents_comments
    Comment.where(post_id: id).limit(5).order(created_at: :desc)
  end

  private

  def update_counter_post
    User.increment_counter(:posts_counter, author_id)
  end
end
