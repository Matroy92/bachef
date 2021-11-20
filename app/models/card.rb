class Card < ApplicationRecord
  has_many :cardgames
  has_many :games, through: :cardgame
  has_many :orders, dependent: :destroy

  validates :title, presence: true
  validates :category, presence: true
  validates :calories, presence: true

  # before_validation :good_title

  def primary_color
    {
      "Fruits & Légumes" => 'green',
      "Viande & Fruits de mer" => 'blue',
      "Accompagnement" => 'orange',
      "Dessert" => 'red'
    }[category]
  end

  monetize :price_cents

private

  # def good_title
  #   self.title = self.title.gsub("ô", "o")
  # end

end
