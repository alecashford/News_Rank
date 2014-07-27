class ArticlesController < ApplicationController

  def get_all_articles
    result = []
    # user = current_user
    user = User.find(1)
    feeds = user.feeds
    feeds.each do |feed|

      article_hash = {}
      feed.articles.each do |article|
        article_hash["title"] = article.title
        article_hash["source"] = article.site_url
        article_hash["linkUrl"] = article.canonical_url
        article_hash["imageUrl"] = article.visual_url
        article_hash["timePublished"] = article.published
        article_hash["newsRank"] = article.calculated_rank
        article_hash["summary"] = article.summary
        result << article_hash
      end
    end
    result.to_json
  end

end

