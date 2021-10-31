# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

CardGame.delete_all
puts 'Card games deleted'

Game.delete_all
puts 'Card games deleted'

Card.delete_all
puts 'Cards deleted'

User.delete_all
puts "Users deleted"

puts 'Create some users...'

adeline = User.create!(username:'Test', email:'test@test.com', password:'123456')
adeline = User.create!(username:'Adeline', email:'adeline@cortijos.com', password:'123456')
zak = User.create!(username:'Zak', email:'zak@lamjoun.com', password:'123456')
mathieu = User.create!(username:'Mathieu', email:'mathieu@royer.com', password:'123456')
emilien = User.create!(username:'Emilien', email:'emilien@testu.com', password:'123456')
puts 'Some users created ! '

puts 'Create some cards... '

csv_options = { col_sep: ';', headers: :first_row }
filepath    = 'app/assets/seed/cards.csv'

CSV.foreach(filepath, csv_options) do |row|
    Card.create!(title: row['title'], category: row['category'], calories: row['calories'], premium: row['premium'] == 'true',
    price_cents: row['price_cents'])
  end
  puts 'Some cards created ! '

puts 'Create some games...'
game1 = Game.create!(user_id: emilien.id, objective: 'Equilibre', calories: 800)
game2 = Game.create!(user_id: emilien.id, objective: 'Végétarien', calories: 500)
puts 'Some games created ! '

puts 'Attach the cards...'
CardGame.create!(game_id: game1.id, card_id: Card.ids.sample)
CardGame.create!(game_id: game1.id, card_id: Card.ids.sample)
CardGame.create!(game_id: game1.id, card_id: Card.ids.sample)
CardGame.create!(game_id: game2.id, card_id: Card.ids.sample)
CardGame.create!(game_id: game2.id, card_id: Card.ids.sample)
puts 'Cards attached ! '