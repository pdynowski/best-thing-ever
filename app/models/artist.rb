class Artist < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :elo_score, presence: true

  has_many :winning_votes, foreign_key: :winner_id, class_name: 'Vote'
  has_many :losing_votes, foreign_key: :loser_id, class_name: 'Vote'

  def format_artist_name_for_url
    artist_name = self.name.gsub(/\+/,'and')
    artist_name = artist_name.gsub(/&/,'and').downcase
    artist_name = artist_name.gsub(/\s/,'+')
    artist_name = URI::encode(artist_name)
    artist_name = artist_name.gsub(/%E2%80%90/, '-')
  end

  def get_image_url
    if self.image_url == nil
      artist_name = format_artist_name_for_url
      url = "http://ws.audioscrobbler.com/2.0/?method=artist.getInfo&artist=#{artist_name}&api_key=#{Rails.application.secrets.lastfm_api_key}&format=json"
      p url
      uri = URI(url)
      data = Net::HTTP.get(uri)
      parsed = JSON.parse(data)
      self.image_url =  parsed["artist"]["image"][-3]["#text"].to_s
      self.save
      self.image_url
    else
      self.image_url
    end
  end

  class << self
    def get_random_artist
      Artist.all.shuffle[1]
    end

    def score(votes = Vote.all)
      artist_hash = {}

      votes.each do |vote|
        artist_hash[vote.winner_id] ||= 1500
        artist_hash[vote.loser_id] ||= 1500

        new_scores = Artist.assign_elo_points({
          winner: artist_hash[vote.winner_id],
          loser: artist_hash[vote.loser_id]
          })

        artist_hash[vote.winner_id] = new_scores[:winner]
        artist_hash[vote.loser_id] = new_scores[:loser]
      end
        return artist_hash
    end

    def assign_elo_points(voted_artists)
      k_factor = 32
      winner_expectation = calc_expectation(voted_artists)
      loser_expectation = 1 - winner_expectation
      voted_artists[:winner] += (k_factor * (1 - winner_expectation)).to_i
      voted_artists[:loser] += (k_factor * (0 - loser_expectation)).to_i
      return voted_artists
    end

    private

    def calc_expectation(voted_artists)
      winner_score = voted_artists[:winner]
      loser_score = voted_artists[:loser]
      expectation_denominator =
        1 + 10**((loser_score - winner_score)/400.0)
      return 1.0/expectation_denominator
    end
  end
end
