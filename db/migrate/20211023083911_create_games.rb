class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :recipe_title
      t.string :recipe_content
      t.string :recipe_comment
      t.integer :user_rating
      t.string :objective
      t.integer :calories
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
