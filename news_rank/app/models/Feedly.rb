require "HTTParty"

class FeedlyFeed
  include HTTParty # remove this later
  @@base_uri = "http://cloud.feedly.com/v3/"

  def initialize(feed_id)
    @feed_id = feed_id
  end

  # This gets the feed metadata
  def metadata
    HTTParty.post("#{@@base_uri}feeds/.mget",
                  headers: {'Content-type' => 'application/json'},
                  body: JSON.dump([@feed_id]))
  end

  # This a helper method
  def stream
    HTTParty.get("#{@@base_uri}streams/contents?streamId=#{@feed_id}") 
  end

  # This returns an array of articles
  def articles
    self.stream["items"].map do |item|
      item
    end
  end

  # This gets the last update of the feed
  def last_update
    self.stream["updated"]
  end

  # This returns the continuation id to pass to the next stream call, for pagination. 
  # This id guarantees that no entry will be duplicated in a stream
  def continuation
    self.stream["continuation"]
  end

  # This will dump the feed content into the database
  # WIP, havent finished this part
  def dump
    self.stream["items"].map do |item|
      p item["title"]
      p item["id"] # feedly Article ID
      p item["published"]
      p item["author"]
      p item["alternate"][0]["href"] # permalink
      p item["content"]["content"] # this is HTML
    end
  end

end