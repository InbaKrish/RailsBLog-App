class AddUsersToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :user, :int
  end
end
