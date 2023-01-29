require 'rails_helper'

RSpec.describe User, type: :model do
  context 'ensures the present of fields' do
    it 'ensures role is present' do
      user = User.new(email: 'mail@mail.com', password: 'password112233', role: 0)
      expect(user.valid?).to eq(true)
    end
  end

  context 'validation tests' do
    it 'user`s role should be zero (0) by default' do
      user = User.new(role: 0)
      expect(user.role).to eq('user')
    end

    it 'admin`s role should be 1' do
      user = User.new(role: 1)
      expect(user.role).to eq('admin')
    end

    it 'super admin`s role should be 2' do
      user = User.new(role: 2)
      expect(user.role).to eq('super_admin')
    end

    it 'should be three types of roles (user, admin and super_admin) + default (user)' do
      expect(User.roles.values.count).to eq(4)
    end
  end

  context 'scope(methods) tests' do
    it 'class User should have method user_rated_this_movie?' do
      # standard users from db/seed
      user1_id = User.where(email: 'user@mail.com').first.id

      movie = Movie.create(title: 'Some text', text: 'Some text')
      movie2 = Movie.create(title: 'Some text2', text: 'Some text2')
      movie3 = Movie.create(title: 'Some text3', text: 'Some text3')

      r = Rating.create(user_id: user1_id, movie_id: movie.id, grade: 9)
      r2 = Rating.create(user_id: user1_id, movie_id: movie2.id, grade: 9)

      expect(User.user_rated_this_movie?(user1_id, movie.id)).to eq(true)
      expect(User.user_rated_this_movie?(user1_id, movie2.id)).to eq(true)
      expect(User.user_rated_this_movie?(user1_id, movie3.id)).to eq(false)

      r.delete; r2.delete; movie.delete; movie2.delete; movie3.delete
    end
  end

  context 'relation (relationships with other tables)' do
    it 'user should have many ratings' do
      should have_many :ratings
    end
  end
end
