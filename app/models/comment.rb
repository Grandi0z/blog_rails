class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def self.update_comments_counter(post_id)
    Post.increment_counter(:comments_counter, post_id)
  end
end
