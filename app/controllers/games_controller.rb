class GamesController < ApplicationController
  

  def index
   @games = Game.where(saved: true).all
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
      @cards = Card.where(premium: false)
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
      test_scrap
   end

   def saved
      @game = Game.find(params[:id])
      @game.update(saved: true)
      redirect_to games_path
   end

   private

   def game_params
      params.require(:game).permit(:objective, :calories)
   end

  def test_scrap
    @game = Game.find(params[:id])
    @ingredients = @game.cards.pluck(:title).join("-")

    url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{@ingredients}" #ok
    # url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=Banane-Poulet+roti+(100g)-Frites" #ok
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    @results =  []
    html_doc.search('.MRTN__sc-1gofnyi-2.gACiYG').each do |element|
      #puts "\n\n\n#{element.text.strip}\n\n\n"
      #puts element.text.strip
      link = element.attribute("href").value
      test = element.search(".MRTN__sc-30rwkm-0.dJvfhM").text.strip
      @results << {link: link, title: test}
    end
 
  end

end
