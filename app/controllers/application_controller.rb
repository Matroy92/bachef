class ApplicationController < ActionController::Base
    def index
    @cards = Card.all
    end
end
