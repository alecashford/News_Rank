module GetScores

  class RedditFetcher
    def initialize(url)
      @url = url
    end

    def fetch
      p "fetching from reddit..."
      response = HTTParty.get("http://www.reddit.com/api/info.json?url=#{@url}")
    rescue
        nil
    end

    def scores
      p "Now in reddit fetcher."
      if fetch
        P "Fetch is true!"
        score = 0
        num_comments = 0
        fetch["data"]["children"].each do |article|
          score += article["data"]["score"]
          num_comments += article["data"]["num_comments"]
        end
      end
      p "supposedly about to return the scores..."
      {
        score: score,
        num_comments: num_comments
      }
    end
  end
end
