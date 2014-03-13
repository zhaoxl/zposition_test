class ArticlesController < ApplicationController
  def index
    @articles_grid = initialize_grid(Article)
  end
end
