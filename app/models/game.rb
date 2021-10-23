class Game < ApplicationRecord
  belongs_to :user
  has_many :cards, through: :cardgame

  validates :objective, presence: true
  validates :calories, presence: true
end
