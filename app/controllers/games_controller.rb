require "pry-byebug"
require 'open-uri'
require 'nokogiri'

class GamesController < ApplicationController
  def test_scrap
    if params[:query].present?
      url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{params[:query]}" #ok
      html_file = URI.open(url).read
      html_doc = Nokogiri::HTML(html_file)
      html_doc.search('.MRTN__sc-30rwkm-0.dJvfhM').each do |element|
        #puts "\n\n\n#{element.text.strip}\n\n\n"
        #puts element.text.strip
        @test = element.text.strip
        
        
        
      end
      
    end
  end

  def index
    
  end

   def new
      @game = Game.new
   end

   def create
      @game = Game.new(game_params)
      @game.user = current_user
      if @game.save
         redirect_to game_path(@game)
       else
         render :new
       end
   end

   def show
      @game = Game.find(params[:id])
      @cards = Card.all
   end
   
   def update
      @game = Game.find(params[:id])
      @card_game = params.dig(:game, :card_ids).reject(&:blank?).each do |card_id|
      CardGame.create(game: @game, card: Card.find(card_id))
      end
      redirect_to finish_game_path(@game)
   end

   def calories_sum(game)
      sum = 0
      game.cards.each do |card_calories|
         sum += card_calories.calories
      end
      return sum
   end
   
   def finish
      @game = Game.find(params[:id])
      @calories = calories_sum(@game)
   end


   private

   def game_params
      params.require(:game).permit(:objective, :calories)
   end

end
