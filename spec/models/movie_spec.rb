require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'ensures the present of fields' do
    it 'ensures title is present' do
      movie = Movie.new(title: 'Some title', text: 'Some text', rating: 1)
      expect(movie.valid?).to eq(true)
    end
  end

  context 'validation tests' do
    it 'rating should be zero (0) by default' do
      movie = Movie.new(title: 'Some text', text: 'Some text')
      expect(movie.rating).to eq(0)
    end

    it 'rating should be with values form 1 to 10 (float)' do
      # by default 0 means that nobody left one's grade to the movie

      m1 = Movie.new(title: 'Some text', text: 'Some text', rating: 7.6)
      m2 = Movie.new(title: 'Some text2', text: 'Some text2', rating: -0.1)
      m3 = Movie.new(title: 'Some text3', text: 'Some text3', rating: 10.1)

      expect(m1.save).to eq(true)
      expect(m2.save).to eq(false)
      expect(m3.save).to eq(false)
    end
  end

  context 'scope(methods) tests' do
    before(:each) do
      3.times { Movie.create(title: 'Some text', text: 'Some text', rating: 0) }
      Movie.create(title: 'Some text', text: 'Some text', rating: 5)
      Movie.create(title: 'Some text2', text: 'Some text2', rating: 8.5)
    end
    
    it 'should be able to select already_rated movies' do
      expect(Movie.already_rated.count).to eq(2)
    end

    it 'should be able to select not_rated_yet movies' do
      expect(Movie.not_rated_yet.count).to eq(3)
    end

    it 'should be able to search movies by title' do
      expect(Movie.search_movies_by_title('some title').class.to_s).to eq('Movie::ActiveRecord_Relation')
    end

    it 'should be able to search movies by categories' do
      movie = Movie.create(title: 'Some text', text: 'Some text')
      movie2 = Movie.create(title: 'Some text2', text: 'Some text2')

      # Fantasy: 10,
      # Romance: 20,

      mc1 = MovieCategory.create(movie_id: movie.id, category_id: 10)
      mc2 = MovieCategory.create(movie_id: movie.id, category_id: 20)

      mc3 = MovieCategory.create(movie_id: movie2.id, category_id: 10)

      expect(Movie.search_movies_by_categories('Fantasy').ids).to eq([movie2.id, movie.id])
      expect(Movie.search_movies_by_categories('Romance').first.id).to eq(movie.id)

      mc1.delete; mc2.delete; mc3.delete; movie.delete; movie2.delete;
    end
  end

  context 'relation (relationships with other tables)' do
    it 'movie should have many ratings' do
      should have_many :ratings
    end

    it 'movie should have many movie categories' do
      should have_many :movie_categories
    end

    it 'movie should have one attached associations to image (ActiveRecord, ActiveStorage)' do
      should have_one_attached :image
    end

    it 'movie should have one attached associations to image (ActionText trix editor)' do
      should have_rich_text :text
    end
  end
end
