require 'rails_helper'

RSpec.describe Rating, type: :model do
  context 'ensures the present of fields' do
    it 'ensures user_id is present' do
      user = User.create(email: 'mails@mail.com', password: 'here_password')
      movie = Movie.create(title: 'Some text1', text: 'Some text')

      rating = Rating.new(user_id: user.id, movie_id: movie.id, grade: 5)
      expect(rating.valid?).to eq(true)
      movie.delete; user.delete
    end
  end

  context 'validation tests' do
    it 'grade should be with values form 1 to 10 (integer)' do
      # one user
      user = User.create(email: 'm@mail.com', password: 'here_password')

      # four movies
      movie1 = Movie.create(title: 'Some text1', text: 'Some text')
      movie2 = Movie.create(title: 'Some text2', text: 'Some text')
      movie3 = Movie.create(title: 'Some text3', text: 'Some text')
      movie4 = Movie.create(title: 'Some text4', text: 'Some text')

      # four rating
      r1 = Rating.new(user_id: user.id, movie_id: movie1.id, grade: 6)
      r2 = Rating.new(user_id: user.id, movie_id: movie2.id, grade: 5.5)
      r3 = Rating.new(user_id: user.id, movie_id: movie3.id, grade: 0)
      r4 = Rating.new(user_id: user.id, movie_id: movie4.id, grade: 11)

      expect(r1.save).to eq(true); r1.delete
      expect(r2.save).to eq(false); r2.delete
      expect(r3.save).to eq(false); r3.delete
      expect(r4.save).to eq(false); r4.delete
    end

    it 'filed user_id must belong to only exist user' do
      # one existing user
      user = User.create(email: 'm@mail.com', password: 'here_password')

      # one existing movie
      movie = Movie.create(title: 'Some text', text: 'Some text')

      r1 = Rating.new(user_id: 246, movie_id: movie.id, grade: 6)
      r2 = Rating.new(user_id: user.id, movie_id: movie.id, grade: 6)

      expect(r1.save).to eq(false); r1.delete
      expect(r2.save).to eq(true); r2.delete
    end

    it 'filed movie_id must belong to only exist movie' do
      # one existing user
      user = User.create(email: 'm@mail.com', password: 'here_password')

      # one existing movie
      movie = Movie.create(title: 'Some text', text: 'Some text')

      r1 = Rating.new(user_id: user.id, movie_id: 521, grade: 6)
      r2 = Rating.new(user_id: user.id, movie_id: movie.id, grade: 6)

      expect(r1.save).to eq(false); r1.delete
      expect(r2.save).to eq(true); r2.delete
    end
  end

  context 'relation (relationships with other tables)' do
    it 'ratings should belong to many movies and users' do
      should belong_to :user
      should belong_to :movie
    end
  end
end
