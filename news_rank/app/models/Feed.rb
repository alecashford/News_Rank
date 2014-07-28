class Feed < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :articles
  validates :feedly_feed_id, uniqueness: true

def update_feed
  helper = FeedlyHelper.new(self.feedly_feed_id)
  updated = helper.last_update
  if (Time.now.to_i * 1000) > (updated + 900000)
    helper.add_to_db
  end
end

end