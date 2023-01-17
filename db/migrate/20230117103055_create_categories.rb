class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories, primary_key: %i[movie_id movie_category] do |t|
      t.belongs_to :movie, null: false, foreign_key: true
      t.integer :movie_category, default: 0, null: false

      t.timestamps
    end
  end
end
