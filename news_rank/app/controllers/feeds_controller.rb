class FeedsController < ApplicationController

  def index
    user=current_user
    feeds = user.feeds
    # update articles in feed
  end

  #Currently this leaves the following fields blank:
  # number of subscribers, description, topics
  def from_opml(file)
    f = File.open(file)
    doc = Nokogiri::XML(f)
    doc.xpath("//outline").each do |x|
      unless x['xmlUrl']==nil
        feed = Feed.new
          feed.url = x['xmlUrl']
          feed.name = x['title']
          feed.feedly_feed_id = "feed/#{x['xmlUrl']}"
          feed.save
          #assumes if not saved, feed already exists
        if !feed.save
          feed = Feed.find_by_feedly_feed_id(feed.feedly_feed_id)
        end
        associate_user(feed)
        helper = FeedlyHelper.new(feed.feedly_feed_id)
        helper.dump
      end
    end
  end

  def from_url(feed_url)
    p "wassup"
    finder = FeedlyFinder.new(feed_url)
    result = finder.find
    feed = Feed.new
      feed.url = result["results"][0]["website"]
      feed.name = result['results'][0]['title']
      feed.num_subscribers = result['results'][0]['subscribers']
      feed.feedly_feed_id = result['results'][0]['feedId']
      feed.description = result['results'][0]['description']
      if result['results'][0]['deliciousTags']
        feed.topics = result['results'][0]['deliciousTags'].join(',')
      end
      feed.save
    if !feed.save
      feed = Feed.find_by_feedly_feed_id(feed.feedly_feed_id)
    end
    associate_user(feed)
    helper = FeedlyHelper.new(feed.feedly_feed_id)
    helper.dump
  end

  def associate_user(feed)
    user = User.find(1)
    user.feeds << feed
  end

end
