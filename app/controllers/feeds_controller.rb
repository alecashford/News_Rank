require 'open-uri'
require 'awesome_print'

class FeedsController < ApplicationController

  def index
    render json: current_user.feeds
  end

  def create
    finder = FeedlyFinder.new(params[:url])
    result = finder.find
    feed = Feed.find_by_feedly_feed_id(params[:url])
    if !feed
      feed = Feed.new
        feed.url = result["results"][0]["website"]
        feed.name = result['results'][0]['title']
        feed.num_subscribers = result['results'][0]['subscribers']
        feed.feedly_feed_id = result['results'][0]['feedId']
        feed.description = result['results'][0]['description']
        if result['results'][0]['deliciousTags']
          feed.topics = result['results'][0]['deliciousTags'].join(',')
        end
      feed.save
    end

    current_user.feeds << feed
    helper = FeedlyHelper.new(feed.feedly_feed_id)
    helper.add_to_db
    render nothing: true
  end

  def destroy
    feed=Feed.find(params[:id])
    feed.destroy
  end

  #Currently this leaves the following fields blank:
  # number of subscribers, description, topics
  # def from_opml
  #   f = File.open(params[:file])
  #   doc = Nokogiri::XML(f)
  #   doc.xpath("//outline").each do |x|
  #     unless x['xmlUrl']==nil
  #       feed = Feed.new
  #         feed.url = x['xmlUrl']
  #         feed.name = x['title']
  #         feed.feedly_feed_id = "feed/#{x['xmlUrl']}"
  #         feed.save
  #         #assumes if not saved, feed already exists
  #       if !feed.save
  #         feed = Feed.find_by_feedly_feed_id(feed.feedly_feed_id)
  #       end
  #       current_user.feeds << feed
  #       helper = FeedlyHelper.new(feed.feedly_feed_id)
  #       helper.dump
  #     end
  #   end
  # end



  def search
    search = FeedlyFinder.new(URI::encode(params[:url]))
    result = search.find
    to_return = []
    result["results"].each do |item|
      to_return << {title: item["title"], subscribers: item["subscribers"], feedId: item["feedId"], url: item["website"]}
    end
    render :json => to_return
  end

end
