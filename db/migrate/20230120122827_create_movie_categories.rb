class CreateMovieCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_categories do |t|
      t.belongs_to :movie, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true
    end
  end
end
