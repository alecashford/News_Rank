require 'spec_helper'

describe Article do
  describe "validations" do
    it {should allow_value(1).for(:published)}
    it {should validate_uniqueness_of :canonical_url}
  end

  it "belongs to a feed" do
    test_feed = Feed.create()
    article = Article.create(feed_id: test_feed.id)
    expect(article.feed.id).to eq(test_feed.id)
  end

end
