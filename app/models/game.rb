class Game < ApplicationRecord
  OBJECTIVE_TYPE = %w(Vegan Végétarien Equilibré Gras)
  belongs_to :user
  has_many :card_games, dependent: :destroy
  has_many :cards, through: :card_games
  has_many :recipes, dependent: :destroy

  validates :objective, presence: true, inclusion: { in: OBJECTIVE_TYPE}
  validates :calories, presence: true

  def score
    cards.map { |card_calories| card_calories.calories}.sum
  end
end
