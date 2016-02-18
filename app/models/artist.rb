class Artist < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :elo_score, presence: true

  has_many :winning_votes, foreign_key: :winner_id, class_name: 'Vote'
  has_many :losing_votes, foreign_key: :loser_id, class_name: 'Vote'
end
