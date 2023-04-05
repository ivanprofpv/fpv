class SearchController < ApplicationController
  def index
    @search_result = Drone.search(params[:query])
  end
end
