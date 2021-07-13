class Movie
  include Mongoid::Document
  include Mongoid::Timestamps
  include MongoidVote::Voteable

  field :title, type: String, default: ""
  field :description, type: String

  belongs_to :author, class_name: 'User'
end
