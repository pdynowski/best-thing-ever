class VotesController < ApplicationController

  def new
    @option1 = Artist.get_random_artist
    @option2 = Artist.get_random_artist
    unless @option1 != @option2
      @option2 = Artist.get_random_artist
    end
    @vote = Vote.new()
  end

end
