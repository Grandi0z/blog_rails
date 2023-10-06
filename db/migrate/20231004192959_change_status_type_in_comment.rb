class ChangeStatusTypeInComment < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :textra, :text
  end
end
