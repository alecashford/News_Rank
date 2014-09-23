class Article < ActiveRecord::Base
 belongs_to :feed
 validates :canonical_url, uniqueness: true
 before_save :calculate_rank

def add_article(item, feed)
    p "get here? 1"
    p "item"
    p item
    p "feed"
    p feed
    p "self"
    p self
     self.title = item["title"]
     self.feed_id = feed.id
     self.feedly_id = item["origin"]["streamId"] # feedly feed/stream ID
     self.published = item["published"]
     self.author = item["author"]
     self.canonical_url = item["alternate"][0]["href"] # permalink
     self.summary = item["summary"]["content"] # this is HTML
     self.site_url = item["origin"]["htmlUrl"]
     if item["visual"]
       self.visual_url = item["visual"]["url"]
       self.visual_height = item["visual"]["height"]
       self.visual_width = item["visual"]["width"]
     end
     p "get here? 2"
     self.twitter_count = GetScores::TwitterFetcher.new(self.canonical_url).count
        reddit_scores = GetScores::RedditFetcher.new(self.canonical_url)
        self.reddit_score = reddit_scores.score
        self.reddit_comment_count = reddit_scores.num_comments
        fb_scores = GetScores::FacebookFetcher.new(self.canonical_url).scores
        self.fb_share_count = fb_scores[self.canonical_url][:shares]
        self.fb_like_count = fb_scores[self.canonical_url][:likes]
        self.fb_comment_count = fb_scores[self.canonical_url][:comments]

     self.save
     p "get here? 3"
end

########## Scoring Algorithm

REDDIT_WEIGHT = 0.4
FB_LIKE_WEIGHT = 0.1
FB_SHARE_WEIGHT = 0.2
TWITTER_WEIGHT = 0.3

  def calculate_rank
    reddit_score = normalize_reddit_score
    twitter_score = normalize_twitter_count
    fb_share_score = normalize_fb_share_count
    fb_like_score = normalize_fb_like_count
    final_score = REDDIT_WEIGHT*reddit_score+FB_SHARE_WEIGHT*fb_share_score+FB_LIKE_WEIGHT*fb_like_score+TWITTER_WEIGHT*twitter_score
    self.calculated_rank = final_score*time_decay
  end

  # privatea

  def normalize_reddit_score
    raw_score = self.reddit_score ||= 0.1 #Defaults to 50th percentile
    p_val = 2.5722299483384*10**-6 #4.57409E-06
    r_val = 21.0227404222522
    100*percentile(p_val, r_val, raw_score+0.01) #Can't be 0
  end

  def normalize_twitter_count
    raw_score = self.twitter_count ||= 0.11 #Defaults to 48th percentile
    p_val = 4.57409*10**-6 #4.57409E-06
    r_val = 21.0232094852343
    100*percentile(p_val, r_val, raw_score + 0.01)
  end

  def normalize_fb_share_count
    raw_score = self.fb_share_count ||= 0.1 #Defaults to 50th percentile
    p_val = 1.82200271500748*10**-6 #4.57409E-06
    r_val = 22.0222204349218
    100*percentile(p_val, r_val, raw_score+0.01)
  end

  def normalize_fb_like_count
    raw_score = self.fb_like_count ||= 0.1 #Defaults to 50th percentile
    p_val = 6.3528910358755*10**-7
    r_val = 24.0204797504855
    100*percentile(p_val, r_val, raw_score+0.01)
  end

  def percentile(p_val, r_val, raw_val)
    base = Math::E # for natural log
    Math.log(raw_val/p_val, base)/r_val
  end

  def time_decay
    published = self.published ||= Time.now.to_i
    time_published = Time.at(self.published).to_datetime
    now = DateTime.now
    hours_since = ((now - time_published)*24).to_f
    decay = 1/(hours_since+5)**0.3
  end

end
