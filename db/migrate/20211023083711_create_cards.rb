class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :title
      t.string :category
      t.integer :calories

      t.timestamps
    end
  end
end
