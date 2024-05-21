require "json"
require "open-uri"
class GamesController < ApplicationController

  # new action will be used to display a new random grid and a form.
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  # The form will be submitted (with POST) to the score action
  def score
    @word = params[:word]
    @letters = params[:letters].split

    url = "https://dictionary.lewagon.com/#{@word}"
    user_serialized = URI.open(url).read
    result = JSON.parse(user_serialized)

    valid = result["found"]

    matched = true

    @word.split.each do |letter|
      unless @letters.include?(letter)
        matched = false
      end
    end
    raise
    if matched
      # check valid
      if valid
        # matches and is valid
        @result = "<strong>Congratulations!<strong> #{@word} is a valid English word!"
      else
        # matches but not a valid word
        @result = "Sorry but #{@word} doesn't seem to be a valid English word"
      end
    else
      # not included
      @result = "Sorry but #{@word} can't be built out of #{@letters}"
    end
  end
end
