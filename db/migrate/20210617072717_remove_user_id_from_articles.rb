class RemoveUserIdFromArticles < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :user_id 
    remove_column :savedarticles, :user_id 
  end
end
