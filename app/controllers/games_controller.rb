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
         redirect_to root_path
       end
    end

    def show
       @game = Game.find(params[:id])
    case @game.objective
       when 'Végétarien'
          @cards = Card.where.not(category: 'Viande & Fruits de mer')
       when 'Gras'
          @cards = Card.where.not(category: 'Fruits & Légumes')
       when 'Vegan'
          @cards = Card.where.not(category: 'Viande & Fruits de mer')
       when 'Equilibré'
          @cards = Card.all
       end
       @cards = Card.where(premium: false)
    end

    def update
       @game = Game.find(params[:id])
       @card_game = params.dig(:game, :card_ids).reject(&:blank?).each do |card_id|
       CardGame.create(game: @game, card: Card.find(card_id))
       end
       redirect_to finish_game_path(@game)
    end

    def finish
       selected_card_ids = params[:card_ids].split(',').map(&:to_i)
       @game = Game.find(params[:id])
       @game.card_ids = selected_card_ids
       @game.save
       render json: {url: finish_show_game_path }
    end

    def finish_show
       @game = Game.find(params[:id])
       @calories =  @game.score
       recipes_scrap
       @recipes.first(3).each do |recipe|
         Recipe.create(game: @game, link: recipe[:link], title: recipe[:title], duration: recipe[:duration], 
                        difficulty: recipe[:difficulty], price: recipe[:price], picture: recipe[:picture])
      end
    end

    def saved
      @game = Game.find(params[:id])
      title = params.dig(:game, :recipe_title)
      content = params.dig(:game, :recipe_content)
      @game.update!(saved: true, recipe_title: title, recipe_content: content)
      redirect_to games_path
    end

    def destroy
     @game = Game.find(params[:id])
     @game.destroy
     redirect_to games_path
    end

    private

    def game_params
       params.require(:game).permit(:objective, :calories)
    end

   def recipes_scrap
     @ingredients = @game.cards.pluck(:title).join("-")

     url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{@ingredients}" #ok
     clean_url= url.tr(
       "ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
       "AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz")
     # url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=Banane-Poulet+roti+(100g)-Frites" #ok
     html_file = URI.open(clean_url.gsub(/’/,"")).read
     html_doc = Nokogiri::HTML(html_file, nil, Encoding::UTF_8.to_s)
     @recipes =  []
     html_doc.search('.MRTN__sc-1gofnyi-2.gACiYG').each do |element|
       #puts "\n\n\n#{element.text.strip}\n\n\n"
       #puts element.text.strip
       link = element.attribute("href").value
       test = element.search(".MRTN__sc-30rwkm-0.dJvfhM").text.strip
       picture = element.search(".SHRD__sc-dy77ha-0.vKBPb")[0].values.first
       @recipes << {link: link, title: test, picture: picture}
       break if @recipes.length > 3
     end
     @recipes.each_with_index do |recipe, index|
       recipe_scrap(recipe[:link], index)
     end

   end

     def recipe_scrap(recipe_link, index)
       url = "https://www.marmiton.org#{recipe_link}" #ok
       # url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=Banane-Poulet+roti+(100g)-Frites" #ok
       clean_url= url.tr(
          "ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
          "AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz")
       html_file = URI.open(clean_url.gsub(/’/,"")).read
       html_doc = Nokogiri::HTML(html_file, nil, Encoding::UTF_8.to_s)
       html_doc.search('.RCP__sc-1418ayg-0.fJAlgo').each do |element|
          texts = element.search(".RCP__sc-1418ayg-1.dbYbAl")
         #puts "\n\n\n#{element.text.strip}\n\n\n"
         #puts element.text.strip
          texts.each_with_index do |text, id|
             @recipes[index][:duration] = text.children.text if id == 0
             @recipes[index][:difficulty] =  text.children.text if id == 1
             @recipes[index][:price] = text.children.text if id == 2

             #binding.pry

          end
       end
     end
 end
