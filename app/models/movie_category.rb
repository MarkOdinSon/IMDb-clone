class MovieCategory < ApplicationRecord
  belongs_to :movie
  belongs_to :category

  validates :movie_id, :category_id, presence: true
end
