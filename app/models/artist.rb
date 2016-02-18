class Artist < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :elo_score, presence: true

  has_many :winning_votes, foreign_key: :winner_id, class_name: 'Vote'
  has_many :losing_votes, foreign_key: :loser_id, class_name: 'Vote'


  class << self
    def get_random_artist
      Artist.all.shuffle[1]
    end

    def assign_elo_points(artists)
      k_factor = 32
      winner_expectation = calc_expectation(artists)
      loser_expectation = 1 - winner_expectation
      artists[:winner].elo_score += (k_factor * (1 - winner_expectation)).to_i
      artists[:loser].elo_score += (k_factor * (0 - loser_expectation)).to_i
    end

    private

    def calc_expectation(artists)
      winner_score = artists[:winner].elo_score
      loser_score = artists[:loser].elo_score
      expectation_denominator =
        1 + 10**((loser_score - winner_score)/400.0)
      return 1.0/expectation_denominator
    end
  end
end
