# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

CardGame.delete_all
puts 'CardGame deleted'

Card.delete_all
puts 'Cards deleted'

Game.delete_all
puts 'Game deleted'

User.delete_all
puts "Users deleted"

puts 'Create some users...'

adeline = User.create!(username:'Adeline', email:'adeline@cortijos.com', password:'123456')
zak = User.create!(username:'Zak', email:'zak@lamjoun.com', password:'123456')
mathieu = User.create!(username:'Mathieu', email:'mathieu@royer.com', password:'123456')
emilien = User.create!(username:'Emilien', email:'emilien@testu.com', password:'123456')
puts 'Some users created ! '

puts 'Create some cards... '

csv_options = { col_sep: ';', headers: :first_row }
filepath    = 'app/assets/seed/cards.csv'

CSV.foreach(filepath, csv_options) do |row|
    Card.create!(title: row['title'], category: row['category'], calories: row['calories'])
  end
  puts 'Some cards created ! '