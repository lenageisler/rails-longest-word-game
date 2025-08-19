require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    @letters
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @eng_word = eng_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def eng_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
  
end
