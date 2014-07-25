module GetScores
  class FacebookFetcher
    attr_reader :shares, :likes, :comments, :total, :urls
    def initialize(url)
      fb_response = HTTParty.get("http://api.facebook.com/restserver.php?method=links.getStats&format=json&urls=#{url}")
      @likes = fb_response[0]["like_count"]
      @comments = fb_response[0]["comment_count"]
      @shares = fb_response[0]["share_count"]
    end
    def total
      @likes + @comments + @shares
    end
  end

  class TwitterFetcher
    attr_reader :count
    def initialize(url)
      tw_response = HTTParty.get("http://cdn.api.twitter.com/1/urls/count.json?url=#{url}")
      @count = tw_response["count"]
    end
  end

  class RedditFetcher
    attr_reader :score, :num_comments
    def initialize(url)
      @rd_response = HTTParty.get("http://www.reddit.com/api/info.json?url=#{url}")
      @score = 0
      @num_comments = 0
      scrape_scores
    end
    def scrape_scores
      @rd_response["data"]["children"].each do |article|
        @score += article["data"]["score"]
        @num_comments += article["data"]["num_comments"]
      end
    end
  end
end
