feed = Feed.create(
  name: "Engadget",
  url: "http://www.engadget.com",
  feedly_feed_id: "feed/http://feeds.engadget.com/weblogsinc/engadget",
  num_subscribers: 427
)

user = User.create(
  email: "ruhroh@gmail.com",
  password: "12345678")

user.feeds << feed

article = Article.create(
  canonical_url: "http://google.com/thisarticle",
  site_url: "http://google.com",
  visual_url: "http://www.mostbeautifulthings.net/wp-content/uploads/2014/04/sweet-cats-15.jpg",
  visual_height: 1366,
  visual_width: 750,
  author: "Lady Gaga",
  title: "Lady goes GaGa",
  keywords: "cats, gaga, xxx",
  summary: "<p>lore ummmmm ipsummmmmmmmmmmm</p>",
  feed_id: feed.id,
  feedly_id: "feedlyid",
  published: 07/07/07,
  fb_share_count: 27,
  fb_like_count: 911,
  fb_comment_count: 666,
  twitter_count: 45,
  reddit_score: 23,
  reddit_comment_count: 34,
  calculated_rank: 2
  )

article2 = Article.create(
  canonical_url: "http://google.com/thisarticle",
  site_url: "http://google.com",
  visual_url: "https://blog.compete.com/wp-content/uploads/2013/04/cats-1.jpg",
  visual_height: 1366,
  visual_width: 750,
  author: "Lady Gaga",
  title: "Lady goes GaGa",
  keywords: "cats, gaga, xxx",
  summary: "<p>lore ummmmm ipsummmmmmmmmmmm</p>",
  feedly_id: feed.id,
  published: 07/07/07,
  fb_share_count: 27,
  fb_like_count: 911,
  fb_comment_count: 666,
  twitter_count: 45,
  reddit_score: 23,
  reddit_comment_count: 34,
  calculated_rank: 2
  )


