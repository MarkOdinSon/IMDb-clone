class Movie < ApplicationRecord
  has_many :ratings
  has_many :movie_categories
  has_many :categories, through: :movie_categories

  # img attached (active storage)
  has_one_attached :image

  scope :already_rated, -> { where.not(rating: 0) }
  scope :not_rated_yet, -> { where(rating: 0) }

  # validations

  validates_presence_of :title, :text, :rating

  validates :title, :text, presence: true

  validates :rating, numericality: { in: 0..10 }
end
