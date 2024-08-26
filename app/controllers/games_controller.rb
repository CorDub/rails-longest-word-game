require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = [ "Y", "Z", "D", "U", "Q", "E", "Z", "Y", "Q", "I" ]
  end

  def score
    letters = params[:letters].split
    params[:guess].upcase.chars do |letter|
      if letters.include?(letter)
        letters.delete_at(letters.index(letter))
      else
        @answer = "Sorry but #{params[:guess]} can't be built out of #{@letters}"
      end
    end

    response =  JSON.parse(URI.open("https://dictionary.lewagon.com/#{params[:guess]}").read())
    if response["found"] == false
      @answer = "Sorry but #{params[:guess]} does not seem to be a valid English word"
    else
      @answer = "Congratulations! #{params[:guess]} is a valid English word!"
    end
  end
end
