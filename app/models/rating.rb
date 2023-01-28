class Rating < ApplicationRecord
  self.primary_keys = :user_id, :movie_id
  belongs_to :user
  belongs_to :movie

  # validations

  validates_presence_of :user_id, :movie_id, :grade

  validates :user_id, :movie_id, :grade, presence: true

  validates :grade, numericality: { only_integer: true, in: 1..10 }

  private

  def self.return_grade_by_movie_id_and_by_user_id(user_id, movie_id)
    rating = Rating.where(user_id: user_id, movie_id: movie_id).first
    return rating.grade unless rating.nil?

    'Not exists'
  end
end
