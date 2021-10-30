class AddPremiumToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :premium, :boolean
  end
end
