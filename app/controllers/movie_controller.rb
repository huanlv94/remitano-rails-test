# MovieConroller: Allow user after login can share Youtube URL
class MovieController < ApplicationController
  before_action :authenticate_user!
  before_action :find_movie, only: %w[vote]

  # Share youtube video
  # POST /movie/share
  def share
    movie = Movie.new(movie_params)
    movie.author = current_user

    return response_json(200, 'success', Movie.response_json(movie).to_json) if movie.save

    response_json(406, movie.errors.full_messages)
  end

  # POST /movie/vote
  def vote
    return response_json(404, 'Movie not found') if vote_params[:id].empty?

    vote = Movie.vote(@movie, current_user, vote_params[:type])
    return response_json(406, "Type #{vote_params[:type]} not supported") unless vote

    response_data = Movie.response_json(@movie)
    response_data[:current_vote] = @movie.current_vote(current_user)
    response_json(200, 'success', response_data)
  end

  private

  def movie_params
    params.require(:movie).permit(:youtube_id, :title, :description)
  end

  def vote_params
    params.require(:movie).permit(:id, :type)
  end

  def find_movie
    @movie = Movie.find(vote_params[:id]) unless vote_params[:id].empty?
  rescue => e
    response_json(404, e.message)
  end

  def response_json(code, mess, data = {})
    render json: {
      statusCode: code,
      message: mess,
      movie: data
    }, status: code
  end
end
