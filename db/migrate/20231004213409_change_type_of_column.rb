class ChangeTypeOfColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :comments_counter, :integer, using: 'comments_counter::integer'
    change_column :posts, :likes_counter, 'integer USING CAST(likes_counter AS integer)'
  end
end
