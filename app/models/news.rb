class News < ActiveRecord::Base
  has_and_belongs_to_many :users
  scope :limit,lambda {|limit|{:limit =>limit}}
  has_many :comments, :dependent => :destroy

  after_save do |news|
    `curl http://localhost:9292/faye -d 'message={"channel":"/news/new", "data":"#{self.data}"}'`
  end
end
