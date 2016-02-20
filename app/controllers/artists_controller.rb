class ArtistsController < ApplicationController

  def index
    @artists_scores = Artist.score
    puts @artists_scores
    @artists = @artists_scores.sort_by do |key, value|
      value
    end
    puts @artists.reverse!
  end

end
