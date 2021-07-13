class MovieController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
  end

  def share
    movie = Movie.new(movie_params)
    unless movie.author == current_user
      render json: {
        statusCode: 422,
        message: 'You is not author with sharing!'
      }, status: 422
    end

    render json: {
      status: 200,
      message: 'success',
      movie: Movie.response_json(movie).to_json
    }, status: 200
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :author, :description)
  end
end
