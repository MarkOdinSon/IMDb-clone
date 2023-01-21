class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      # trix action_text has_rich_text :text instead of t.string :text
      t.float :rating, default: 0

      t.timestamps
    end
  end
end
