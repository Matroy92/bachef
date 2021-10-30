class Card < ApplicationRecord
  has_many :cardgames
  has_many :games, through: :cardgame

  validates :title, presence: true
  validates :category, presence: true
  validates :calories, presence: true

  before_validation :good_title

  def primary_color
    {
      "Fruits & Légumes" => 'green',
      "Viande" => 'blue',
      "Accompagnement" => 'orange',
      "Dessert" => 'red',
    }[category]
  end
  
private

  def good_title
    self.title = self.title.gsub("ô", "o")
  end

end
