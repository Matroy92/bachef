class Card < ApplicationRecord
  has_many :cardgames
  has_many :games, through: :cardgame

  validates :title, presence: true
  validates :category, presence: true
  validates :calories, presence: true
end
