class Vote < ActiveRecord::Base
  validates :winner_id, presence: true
  validates :loser_id, presence: true

  belongs_to :winner, class_name: "Artist"
  belongs_to :loser, class_name: "Artist"
  belongs_to :user, dependent: :destroy
end
