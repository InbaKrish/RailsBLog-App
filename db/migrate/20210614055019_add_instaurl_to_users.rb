class AddInstaurlToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :instaurl, :string
  end
end
