require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'ensures the present of fields' do
    it 'ensures movie_id is present' do
      category = Category.new(movie_id: 10)
      expect(category.valid?).to eq(false)
    end

    it 'ensures movie_category is present' do
      category = Category.new(movie_category: 5)
      expect(category.valid?).to eq(false)
    end
  end

  context 'validation tests' do
    it 'category should be zero (0) by default' do
      movie = Movie.create(title: 'Some title', text: 'Some text')
      category = Category.new(movie_id: movie.id)
      expect(category.movie_category.to_i).to eq(0)
    end

    it 'categories should be in alphabetical order' do
      list_of_categories_keys = Category.all.movie_categories.keys
      expect(list_of_categories_keys == list_of_categories_keys.sort).to eq(true)
    end

    it 'categories should be 26' do
      expect(Category.movie_categories.count).to eq(26)
    end

    it 'categories should be with values form 0 to 25 one after another' do
      list_of_categories_values = Category.all.movie_categories.values
      temp = 0
      list_of_categories_values.each do |i|
        break unless i == temp

        temp += 1
      end
      expect(temp - 1).to eq(25)
    end
  end

  context 'relation (relationships with other tables)' do
    it 'categories should belong to movies' do
      should belong_to :movie
    end
  end
end
