class Movie < ApplicationRecord
  has_many :ratings

  scope :already_rated, -> { where.not(rating: 0) }
  scope :not_rated_yet, -> { where(rating: 0) }

  enum category: {
    Action: 0,
    Adventure: 1,
    Animation: 2,
    Biography: 3,
    Comedy: 4,
    Crime: 5,
    Documentary: 6,
    Drama: 7,
    Family: 8,
    Fantasy: 9,
    FilmNoir: 10,
    GameShow: 11,
    History: 12,
    Horror: 13,
    Music: 14,
    Musical: 15,
    Mystery: 16,
    News: 17,
    RealityTV: 18,
    Romance: 19,
    SciFi: 20,
    Sport: 21,
    TalkShow: 22,
    Thriller: 23,
    War: 24,
    Western: 25,

    #default: :Action
  }

  # validations

  validates_presence_of :title, :text, :category, :rating

  validates :title, :text, presence: true

  validates :category, numericality: { only_integer: true, in: 0..25 }

  validates :rating, numericality: { in: 0..10 }
end
