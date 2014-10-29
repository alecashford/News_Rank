module GetScores
  class FacebookFetcher
    def initialize(url)
      @url = url
    end

    def scores
      {
        likes:    fetch[0]["like_count"],
        comments: fetch[0]["comment_count"],
        shares:   fetch[0]["share_count"]
      }
    end

    def fetch
      p "Now in fb fetcher, about to fetch..."
      HTTParty.get("http://api.facebook.com/restserver.php?method=links.getStats&format=json&urls=#{@url}")
      p "Done with fetching!"
      rescue
        p "Fetching failed :/"
        nil
    end
  end

end
