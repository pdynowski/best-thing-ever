class Vote < ActiveRecord::Base
  validates :winner_id, presence: true
  validates :loser_id, presence: true

  belongs_to :winner, class_name: "Artist"
  belongs_to :loser, class_name: "Artist"

  def self.artist_score
    artist_hash = {}

    Vote.all.each do |vote|
      voted_artists = {
        winner: vote.winner_id,
        loser: vote.loser_id
      }

      if artist_hash.excludes?(voted_artists[:winner])
        artist_hash << voted_artists[:winner] = 1500
      end

      if artist_hash.excludes?(voted_artists[:loser])
        artist_hash << voted_artists[:loser] = 1500
      end

      artists_new_score = assign_elo_points(voted_artists)
      artist_hash[voted_artists[:winner]] = artists_new_score[:winner]
      artist_hash[voted_artists[:loser]] = artists_new_score[:loser]

      return artist_hash
    end

  end

end
