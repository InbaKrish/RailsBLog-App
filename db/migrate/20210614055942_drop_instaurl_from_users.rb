class DropInstaurlFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :instaurl
  end
end
