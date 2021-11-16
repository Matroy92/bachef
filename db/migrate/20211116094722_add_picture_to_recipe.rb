class AddPictureToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :picture, :string
  end
end
