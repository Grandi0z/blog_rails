class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.update_likes_counter(post_id)
    Post.increment_counter(:likes_counter, post_id)
  end
end
