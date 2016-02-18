class Vote < ActiveRecord::Base
  belongs_to :winner, class_name: "Artist"
  belongs_to :loser, class_name: "Artist"
end
