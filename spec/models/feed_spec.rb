require 'spec_helper'

describe Feed do
  describe "validations" do
    it {should validate_uniqueness_of :feedly_feed_id}
    # Test attr_accesible
    # it {should allow_mass_assignment_of :attribute}
  end

  it "has many articles" do
    article1 = Article.create()
    article2 = Article.create()
    feed = Feed.create()
    feed.articles << [article1, article2]
    expect(feed.articles.length).to eq(2)
  end
end