class Movie
  include Mongoid::Document
  include Mongoid::Timestamps
  include MongoidVote::Voteable

  field :title, type: String, default: ""
  field :description, type: String

  belongs_to :author, class_name: 'User'

  def self.response_json(movie)
    return {
      id: movie.id.to_s,
      author_id: movie.author.id.to_s,
      description: movie.description,
      title: movie.title,
      up_count: movie.up_count,
      down_count: movie.down_count
    }
  end
end
