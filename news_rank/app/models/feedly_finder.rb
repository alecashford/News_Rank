class FeedlyFinder
  def initialize(search)
    @search = search
  end

  def find
    HTTParty.get("http://cloud.feedly.com/v3/search/feeds?q=#{@search}")
  end

  def results
    results = []
    self.find["results"].each do |feed|
      feed_hash = {}
      feed_hash["title"] = feed["title"]
      feed_hash['visualUrl'] = feed['visualUrl']
      feed_hash['subscribers'] = feed['subscribers']
      feed_hash['description'] = feed['description']
      feed_hash['feedId'] = feed['feedId']
      feed_hash['topics'] = feed['deliciousTags']
      results << feed_hash
    end
    results
  end
end


