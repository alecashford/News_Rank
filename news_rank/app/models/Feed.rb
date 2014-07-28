class Feed < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :articles
  validates :feedly_feed_id, uniqueness: true
end
