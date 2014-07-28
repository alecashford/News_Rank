class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :subscriptions
  has_many :feeds, through: :subscriptions

  def articles
    articles = []
    self.feeds.each do |feed|
      articles << feed.articles
    end
    p "hey"
    p articles.to_json
    articles.to_json
  end
end
