class Order < ApplicationRecord
  belongs_to :user
  belongs_to :card
  monetize :amount_cents

  
end
