class Game < ApplicationRecord
  OBJECTIVE_TYPE = %w(Vegan Végétarien Equilibré Gras)
  belongs_to :user
  has_many :card_games, dependent: :destroy
  has_many :cards, through: :card_games

  validates :objective, presence: true, inclusion: { in: OBJECTIVE_TYPE}
  validates :calories, presence: true
end
