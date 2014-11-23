class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.integer :user_id
      t.text :comment
      t.integer :news_id

      t.timestamps
    end
  end
end
