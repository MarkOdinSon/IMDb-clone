class Category < ApplicationRecord
  has_many :movie_categories
  has_many :movies, through: :movie_categories

  scope :get_list_categories, -> { Category.all.map(&:name) }

=begin
    enum movie_category: {
    Action: 1,
    Adventure: 2,
    Animation: 3,
    Biography: 4,
    Comedy: 5,
    Crime: 6,
    Documentary: 7,
    Drama: 8,
    Family: 9,
    Fantasy: 10,
    FilmNoir: 11,
    GameShow: 12,
    History: 13,
    Horror: 14,
    Music: 15,
    Musical: 16,
    Mystery: 17,
    News: 18,
    RealityTV: 19,
    Romance: 20,
    SciFi: 21,
    Sport: 22,
    TalkShow: 23,
    Thriller: 24,
    War: 25,
    Western: 26,

    #default: :Action }
=end

  # validations

  validates_presence_of :name
end
