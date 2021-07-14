class HomeController < ApplicationController
  # root path
  # GET /home/index
  def index
    movies = Movie.limit(10).desc(:id)
    @res = []
    movies.each do |m|
      data = Movie.response_json(m)
      current_vote = user_signed_in? ? m.current_vote(current_user) : nil
      data[:current_vote] = current_vote
      @res << data
    end
  end
end
