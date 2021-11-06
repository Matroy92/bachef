class AddSaveFlagToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :saved, :boolean, default: false
  end
end
