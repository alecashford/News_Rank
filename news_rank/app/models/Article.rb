class Article < ActiveRecord::Base
 belongs_to :feed
 validates :canonical_url, uniqueness: true

def add_article(article, feed)
     self.title = article["title"]
     self.feed_id = feed.id
     self.feedly_id = article["origin"]["streamId"] # feedly feed/stream ID
     self.published = article["published"]
     self.author = article["author"]
     self.canonical_url = article["alternate"][0]["href"] # permalink
     self.summary = article["summary"]["content"] # this is HTML
     self.site_url = article["origin"]["htmlUrl"]
     if article["visual"]
       self.visual_url = article["visual"]["url"]
       self.visual_height = article["visual"]["height"]
       self.visual_width = article["visual"]["width"]
     end
     self.save
end

end
