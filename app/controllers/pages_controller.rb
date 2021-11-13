class PagesController < ApplicationController
  def home
    @game = Game.new
  end
  
  def create
    @game = Game.new(game_params)
    @game.user = current_user
    if @game.save
       redirect_to game_path(@game)
     else
       render 'pages#home'
    end
 end
end
