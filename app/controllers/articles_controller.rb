class ArticlesController < ApplicationController

  def get_all_articles
    render json: current_user.articles
  end
end

