class MovieController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
  end

  def share
    movie = Movie.new(movie_params)
    unless movie.author == current_user
      return response_json(422, 'You is not author with sharing!')
    end

    if movie.save
      return response_json(200, 'success', Movie.response_json(movie).to_json)
    else
      return response_json(406, movie.errors.full_messages)
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:youtube_id, :title, :author, :description)
  end

  def response_json(code, mess, data = {})
    render json: {
      statusCode: code,
      message: mess,
      movie: data
    }, status: code
    return
  end
end
