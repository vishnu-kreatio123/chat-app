class CreateTableNewsUsers < ActiveRecord::Migration
  def up
    create_table :news_users do |t|
      t.belongs_to :news
      t.belongs_to :user
    end
  end

  def down
  end
end
