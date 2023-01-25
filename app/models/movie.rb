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

  # Paginator [https://github.com/kaminari/kaminari]
  paginates_per 30 # default

  scope :already_rated, -> { where.not(rating: 0) }
  scope :not_rated_yet, -> { where(rating: 0) }

  # validations

  validates_presence_of :title, :rating

  validates :title, presence: true

  validates :rating, numericality: { in: 0..10 }

  # search for movies on the home (root) page by title
  scope :search_movies_by_title, ->(title) { Movie.where('LOWER(title) LIKE ?', "%#{title.downcase}%").order(id: :desc) }

  def self.search_movies_by_categories(string_of_categories)
    return Movie.all if string_of_categories.nil? || (string_of_categories == '')

    array_of_category_ids = Array.new

    Category.all.each do |i|
      array_of_category_ids.append(i.id) if string_of_categories.include? i.name
    end

    movie_ids = MovieCategory.where(category_id: array_of_category_ids).map(&:movie_id).uniq

    Movie.where(id: movie_ids).order(id: :desc)
  end
end
