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
   
   def finish_game
      @game = Game.find(params[:id])
      cards = params # <= il y aura les cartes selectionnées
      cards.each do |card|
         CardGame.create(game: @game, card: card)
      end

   end

   def display_result
   end

   private

   def game_params
      params.require(:game).permit(:objective, :calories)
   end

end
