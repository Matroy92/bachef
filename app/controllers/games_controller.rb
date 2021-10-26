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

end
