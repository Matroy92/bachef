class RemovePriceFromCards < ActiveRecord::Migration[6.0]
  def change
    remove_column :cards, :price_cents_cents
  end
end
