class HomeController < ApplicationController
  def index
    movies = Movie.limit(10)
    @res = []
    movies.each do |m|
      @res << Movie.response_json(m)
    end
  end
end
