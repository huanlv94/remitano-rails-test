class Movie
  include Mongoid::Document
  include Mongoid::Timestamps
  include Vote

  field :youtube_id, type: String
  field :title, type: String
  field :description, type: String

  belongs_to :author, class_name: 'User'

  validates_presence_of :youtube_id
  validates_uniqueness_of :youtube_id
  validates_length_of :youtube_id, minimum: 8, maximum: 16

  index({ youtube_id: 1 } , { unique: true })

  def self.response_json(movie)
    return {
      id: movie.id.to_s,
      youtube_id: movie.youtube_id,
      author_id: movie.author.id.to_s,
      author_email: movie.author.email,
      description: movie.description,
      title: movie.title,
      up_count: movie.up_count,
      down_count: movie.down_count
    }
  end

  def self.vote(movie, user, type)
    if type == 'up'
      movie.upvote(user)
    else
      movie.downvote(user)
    end

    movie.save!
  end
end
