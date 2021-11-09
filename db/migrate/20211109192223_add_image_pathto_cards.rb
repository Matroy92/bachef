class AddImagePathtoCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :image_path, :string
  end
end
