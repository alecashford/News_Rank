class ArticlesController < ApplicationController

  def get_all_articles
    current_user.articles
  end
end

