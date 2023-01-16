require 'rails_helper'

RSpec.describe Rating, type: :model do
  context 'validation tests' do
    it 'ensures user_id is present' do
      rating = Rating.new(user_id: 10)
      expect(rating.valid?).to eq(false)
    end

    it 'ensures movie_id is present' do
      rating = Rating.new(movie_id: 5)
      expect(rating.valid?).to eq(false)
    end

    it 'ensures grade is present' do
      rating = Rating.new(grade: 5)
      expect(rating.valid?).to eq(false)
    end

    it 'grade should be with values form 1 to 10 (integer)' do
      u = User.create(email: 'm@mail.com', password: 'here_password')
      m = Movie.create(title: 'Some text', text: 'Some text', rating: 0, category: 0)

      r1 = Rating.new(user_id: u.id, movie_id: m.id, grade: 6)
      r2 = Rating.new(user_id: u.id, movie_id: m.id, grade: 5.5)
      r3 = Rating.new(user_id: u.id, movie_id: m.id, grade: 0)
      r4 = Rating.new(user_id: u.id, movie_id: m.id, grade: 11)

      expect(r1.save).to eq(true)
      expect(r2.save).to eq(false)
      expect(r3.save).to eq(false)
      expect(r4.save).to eq(false)
    end

    it 'filed user_id must belong to only exist user' do
      u = User.create(email: 'm@mail.com', password: 'here_password')
      m = Movie.create(title: 'Some text', text: 'Some text', rating: 0, category: 0)

      r1 = Rating.new(user_id: 246, movie_id: m.id, grade: 6)
      r2 = Rating.new(user_id: u.id, movie_id: m.id, grade: 6)

      expect(r1.save).to eq(false)
      expect(r2.save).to eq(true)
    end

    it 'filed movie_id must belong to only exist movie' do
      u = User.create(email: 'm@mail.com', password: 'here_password')
      m = Movie.create(title: 'Some text', text: 'Some text', rating: 0, category: 0)

      r1 = Rating.new(user_id: u.id, movie_id: 521, grade: 6)
      r2 = Rating.new(user_id: u.id, movie_id: m.id, grade: 6)

      expect(r1.save).to eq(false)
      expect(r2.save).to eq(true)
    end
  end
end
