class ArtistsController < ApplicationController

  def index
    @artists_scores = Artist.score
    @artists = @artists_scores.
  end

end
