class MovieCategory < ApplicationRecord
  belongs_to :movie
  belongs_to :category

  # validations

  validates :movie_id, :category_id, presence: true
end
