require 'spec_helper'

describe User do
  describe "validations" do
    it {should validate_uniqueness_of :email}
  end

  it "has many feeds" do
    user = User.create(email: "ga@ga.com", password: "googooforgaga")
    feed1 = Feed.create()
    feed2 = Feed.create()
    feed3 = Feed.create()

    Subscription.create(feed_id: feed1.id, user_id: user.id)
    user.feeds << feed2
    feed3.users << user
    expect(user.feeds.length).to eq(3)
  end

end

