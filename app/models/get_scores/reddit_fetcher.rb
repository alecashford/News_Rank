module GetScores

  class RedditFetcher
    def initialize(url)
      @url = url
    end

    def fetch
      p "Here I am proving that it is not just the url that is messed up:"
      p HTTParty.get("http://www.reddit.com/api/info.json?url=http://dailyjs.com/2012/10/19/cqs/")
      p "Here is the print of what the fetch should look like"
      p HTTParty.get("http://www.reddit.com/api/info.json?url=#{@url}")
      p "fetching from reddit..."
      response = HTTParty.get("http://www.reddit.com/api/info.json?url=#{@url}")
    rescue
        nil
    end

    def scores
      p "Now in reddit fetcher."
      if fetch
        p "Fetch is true!"
        score = 0
        num_comments = 0
        # fetch["data"]["children"].each do |article|
        #   score += article["data"]["score"]
        #   num_comments += article["data"]["num_comments"]
        # end
      end
      p "supposedly about to return the scores..."
      {
        score: score,
        num_comments: num_comments
      }
    end
  end
end
