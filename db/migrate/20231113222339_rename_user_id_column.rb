class RenameUserIdColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :foods, :users_id, :user_id
  end
end
