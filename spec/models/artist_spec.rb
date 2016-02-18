require 'rails_helper'
require 'spec_helper'
describe Artist do
  it {should validate_presence_of :name}
  it {should validate_presence_of :elo_score }
  it {should have_many(:winning_votes).class_name("Vote")}
  it {should have_many(:losing_votes).class_name("Vote")}

  describe "#assign_elo_points" do
    let(:artist_1) { Artist.new(name: "xxx", elo_score: 1500)}
    let(:artist_2) { Artist.new(name: "yyy", elo_score: 1500)}
    it "should assign the correct number of points
      to the winner" do
      Artist.assign_elo_points({winner: artist_1, loser: artist_2})
      expect(artist_1.elo_score).to eq 1516
    end
    it "should assign the correct number of points
      to the loser" do
      Artist.assign_elo_points({winner: artist_1, loser: artist_2})
      expect(artist_2.elo_score).to eq 1484
    end
  end

end
