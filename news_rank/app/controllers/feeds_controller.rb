class FeedsController < ApplicationController


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
    end
  end

  def from_url(feed_url)
    finder = FeedlyFind.new(feed_url)
    result = finder.find
    feed = Feed.new
      feed.url = result["results"][0]["website"]
      feed.name = result['results'][0]['title']
      feed.num_subscribers['results'][0]['subscribers']
      feed.feedly_feed_id = result['results'][0]['feedId']
      feed.save
  end

end
