class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :link
      t.string :title
      t.string :duration
      t.string :difficulty
      t.string :price
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
