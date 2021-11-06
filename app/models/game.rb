class Game < ApplicationRecord
  belongs_to :user
  has_many :card_games
  has_many :cards, through: :card_games

  validates :objective, presence: true, inclusion: { in: %w(Vegan Végétarien Equilibré Gras)}
  validates :calories, presence: true
end
