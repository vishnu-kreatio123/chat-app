class User < ActiveRecord::Base
  has_and_belongs_to_many :news
  has_many :comments, :dependent => :destroy


  def unread_news(user_id)
    count = (News.all.collect(&:id) - ReadMessage.where("user_id = #{user_id}").collect(&:news_id))
    return count
  end

end
