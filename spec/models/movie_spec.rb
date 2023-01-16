require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'validation tests' do
    it 'ensures title is present' do
      movie = Movie.new(title: 'Some title')
      expect(movie.valid?).to eq(false)
    end

    it 'ensures text is present' do
      movie = Movie.new(text: 'Some text')
      expect(movie.valid?).to eq(false)
    end

    it 'ensures category is present' do
      movie = Movie.new(category: 'Documentary')
      expect(movie.valid?).to eq(false)
    end

    it 'ensures rating is present' do
      movie = Movie.new(rating: 1)
      expect(movie.valid?).to eq(false)
    end

    it 'category should be zero (0) by default' do
      movie = Movie.new(title: 'Some text', text: 'Some text')
      expect(movie.category.to_i).to eq(0)
    end

    it 'categories should be 26' do
      expect(Movie.categories.count).to eq(26)
    end

    it 'categories should be in alphabetical order' do
      list_of_categories_keys = Movie.all.categories.keys
      expect(list_of_categories_keys == list_of_categories_keys.sort).to eq(true)
    end

    it 'categories should be with values form 0 to 25 one after another' do
      list_of_categories_values = Movie.all.categories.values
      temp = 0
      list_of_categories_values.each do |i|
        break unless i == temp

        temp += 1
      end
      expect(temp - 1).to eq(25)
    end

    it 'rating should be zero (0) by default' do
      movie = Movie.new(title: 'Some text', text: 'Some text')
      expect(movie.rating).to eq(0)
    end

    it 'rating should be with values form 1 to 10 (float)' do
      # by default 0 means that nobody left one's grade to the movie

      m1 = Movie.new(title: 'Some text', text: 'Some text', rating: 7.6, category: 0)
      m2 = Movie.new(title: 'Some text', text: 'Some text', rating: -0.1, category: 0)
      m3 = Movie.new(title: 'Some text', text: 'Some text', rating: 10.1, category: 0)
      expect(m1.save).to eq(true)
      expect(m2.save).to eq(false)
      expect(m3.save).to eq(false)
    end
  end

  context 'scope tests' do
    before(:each) do
      3.times { Movie.create(title: 'Some text', text: 'Some text', rating: 0, category: 0) }
      Movie.create(title: 'Some text', text: 'Some text', rating: 5, category: 0)
      Movie.create(title: 'Some text', text: 'Some text', rating: 8.5, category: 0)
    end
    
    it 'should be able to select already_rated movies' do
      expect(Movie.already_rated.count).to eq(2)
    end

    it 'should be able to select not_rated_yet movies' do
      expect(Movie.not_rated_yet.count).to eq(3)
    end
  end

  context 'relation (relationships with other tables)' do
    it 'movie should have many ratings' do
      should have_many :ratings
    end
  end
end
