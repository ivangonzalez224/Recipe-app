class RecreateIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index :foods, :user_id
    add_index :foods, :user_id
  end
end
