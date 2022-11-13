class GamesController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def new
    letter_bank = ('a'..'z').to_a
    @letters = 10.times.map { letter_bank.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
