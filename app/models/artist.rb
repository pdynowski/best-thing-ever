class Artist < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :elo_score, presence: true

  has_many :winning_votes, foreign_key: :winner_id, class_name: 'Vote'
  has_many :losing_votes, foreign_key: :loser_id, class_name: 'Vote'


  class << self
    def get_random_artist
      Artist.all.shuffle[1]
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
