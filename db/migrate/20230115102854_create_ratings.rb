class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings, primary_key: %i[user_id movie_id] do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :movie, null: false, foreign_key: true

      t.integer :grade, null: false
      t.timestamps
    end
  end
end
