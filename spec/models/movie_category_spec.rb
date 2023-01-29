require 'rails_helper'

RSpec.describe MovieCategory, type: :model do
  context 'ensures the present of fields' do
    it 'ensures user_id is present' do
      movie = Movie.create(title: 'Some text', text: 'Some text')

      movid_category = MovieCategory.new(movie_id: movie.id, category_id: 1)
      expect(movid_category.valid?).to eq(true)
      movie.delete
    end
  end

  context 'relation (relationships with other tables)' do
    it 'movie category should belong to one movie' do
      should belong_to :movie
    end

    it 'movie category should belong to one category' do
      should belong_to :category
    end
  end
end
