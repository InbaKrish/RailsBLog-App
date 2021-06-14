class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.int :article_id
      t.int :user_id
      t.text :message

      t.timestamps
    end
  end
end