class SubscriptionsController < ApplicationController

  def destroy
    feed = Feed.find(params[:id])
    Subscription.destroy(feed: feed, user: current_user)
  end

end