class Rating < ApplicationRecord
  self.primary_keys = :user_id, :movie_id
  belongs_to :user
  belongs_to :movie
end
