class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :text, null: false
      t.float :rating, default: 0

      t.timestamps
    end
  end
end
