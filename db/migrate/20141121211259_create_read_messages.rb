class CreateReadMessages < ActiveRecord::Migration
  def change
    create_table :read_messages do |t|
      t.integer :user_id
      t.integer :news_id

      t.timestamps
    end
  end
end
