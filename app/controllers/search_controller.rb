class SearchController < ApplicationController
  def index
    @search_result = SearchService.new(params[:query]).call
  end
end
