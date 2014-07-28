include GetScores

class FeedlyHelper
  BASE_URI = "http://cloud.feedly.com/v3/"
  attr_reader :feed_id
  def initialize(feed_id)
    @feed_id = feed_id
  end

  # This gets the feed metadata
  def metadata
    HTTParty.post("#{BASE_URI}feeds/.mget",
                  headers: {'Content-type' => 'application/json'},
                  body: JSON.dump([@feed_id]))
  end

  # This a helper method
  def stream
    begin
      HTTParty.get("#{BASE_URI}streams/contents?streamId=#{@feed_id}")
    rescue
      return nil
    end
  end

  # This returns an array of articles
  def articles
    self.stream["items"].map do |item|
      item
    end
  end

  # This gets timestamp of the last update of the feed by feedly
  def last_update
    if self.stream
      return self.stream["updated"]
    else
      return Time.now.to_i
    end
  end

  # This returns the continuation id to pass to the next stream call, for pagination.
  # This id guarantees that no entry will be duplicated in a stream
  def continuation
    self.stream["continuation"]
  end

  # This will dump the feed content into the databases
  def dump
    if self.stream
      feed = Feed.find_by feedly_feed_id: @feed_id
      self.stream["items"].each do |item|
        a = Article.new
        a.title = item["title"]
        a.feed_id = feed.id
        a.feedly_id = item["origin"]["streamId"] # feedly feed/stream ID
        a.published = item["published"]
        a.author = item["author"]
        a.canonical_url = item["alternate"][0]["href"] # permalink
        a.summary = item["summary"]["content"] # this is HTML
        a.site_url = item["origin"]["htmlUrl"]
        if item["visual"]
          a.visual_url = item["visual"]["url"]
          a.visual_height = item["visual"]["height"]
          a.visual_width = item["visual"]["width"]
        end

        puts a.canonical_url

        a.twitter_count = GetScores::TwitterFetcher.new(a.canonical_url).count
        reddit_scores = GetScores::RedditFetcher.new(a.canonical_url)
        p reddit_scores
        a.reddit_score = reddit_scores.score
        a.reddit_comment_count = reddit_scores.num_comments
        fb_scores = GetScores::FacebookFetcher.new(a.canonical_url).scores
        a.fb_share_count = fb_scores[a.canonical_url][:shares]
        a.fb_like_count = fb_scores[a.canonical_url][:likes]
        a.fb_comment_count = fb_scores[a.canonical_url][:comments]

        a.save
      end
      true
    end
  end

end
