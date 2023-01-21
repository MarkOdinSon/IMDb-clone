class Movie < ApplicationRecord
  has_many :ratings
  has_many :movie_categories
  has_many :categories, through: :movie_categories

  # img attached (active storage)
  has_one_attached :image

  # trix editor
  # Note: you don't need to add Movie.text (Movie.content) field to your messages table [https://edgeguides.rubyonrails.org/action_text_overview.html]
  # But in this situation I use existing field Movie.text, and everything works
  has_rich_text :text

  scope :already_rated, -> { where.not(rating: 0) }
  scope :not_rated_yet, -> { where(rating: 0) }

  # validations

  validates_presence_of :title, :text, :rating

  validates :title, :text, presence: true

  validates :rating, numericality: { in: 0..10 }
end
