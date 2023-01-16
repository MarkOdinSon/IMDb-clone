class Rating < ApplicationRecord
  self.primary_keys = :user_id, :movie_id
  belongs_to :user
  belongs_to :movie

  #validations

  validates_presence_of :user_id, :movie_id, :grade

  validates :user_id, :movie_id, :grade, presence: true

  validates :grade, numericality: { only_integer: true, in: 1..10 }
end
