class User < ApplicationRecord
  has_many :ratings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, admin: 1, super_admin: 2, default: :user }

  private

  def self.user_rated_this_movie?(user_id, movie_id)
    return true if Rating.where(user_id: user_id, movie_id: movie_id).exists?

    false
  end
end
