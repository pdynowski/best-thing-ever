class ArtistsController < ApplicationController

  def index
    artists_scores = Artist.score
    scores_sort = artists_scores.sort_by do |key, value|
      value
    end
    artists = scores_sort.reverse.shift(40)
    artist_ranks = Artist.ranking(artists_scores)
    @artists = artists.map do |artist|
      artist_obj = Artist.find(artist[0])
      [artist_ranks[artist[0]], artist_obj.name, artist[1]]
    end
    @top_ten = @artists[0..9].map do |artist|
      Artist.find_by(name: artist[1])
    end
    @artists
  end

end
