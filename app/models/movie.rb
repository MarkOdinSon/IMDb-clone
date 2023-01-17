class Movie < ApplicationRecord
  has_many :ratings
  has_many :categories

  scope :already_rated, -> { where.not(rating: 0) }
  scope :not_rated_yet, -> { where(rating: 0) }

  # validations

  validates_presence_of :title, :text, :rating

  validates :title, :text, presence: true

  validates :rating, numericality: { in: 0..10 }
end
