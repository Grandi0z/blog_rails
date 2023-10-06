class ChangeColumnDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :posts_counter,nil
    change_column_default :posts, :comments_counter,nil
    change_column_default :posts, :likes_counter, nil
    Post.update_all(comments_counter: nil)
    Post.update_all(likes_counter: nil)
    User.update_all(posts_counter: nil)
  end
end
