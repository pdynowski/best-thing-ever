require 'rails_helper'
require 'spec_helper'
describe Artist do
  it {should validate_presence_of :name}
  it {should validate_presence_of :elo_score }
  it {should have_many(:winning_votes).class_name("Vote")}
  it {should have_many(:losing_votes).class_name("Vote")}

  describe "#assign_elo_points at even start" do
    it "should assign the correct number of points
      to the winner" do
      new_scores = Artist.assign_elo_points({winner: 1500, loser: 1500})
      expect(new_scores[:winner]).to eq 1516
    end
    it "should assign the correct number of points
      to the loser" do
      new_scores = Artist.assign_elo_points({winner: 1500, loser: 1500})
      expect(new_scores[:loser]).to eq 1484
    end
  end

  describe "#assign_elo_points at uneven start if higher wins" do
    it "should assign the correct number of points
      to the winner if 1 wins" do
      new_scores = Artist.assign_elo_points({winner: 1600, loser: 1500})
      expect(new_scores[:winner]).to eq 1611
    end
    it "should assign the correct number of points
      to the loser" do
      new_scores = Artist.assign_elo_points({winner: 1600, loser: 1500})
      expect(new_scores[:loser]).to eq 1489
    end
  end

  describe "#assign_elo_points at uneven start if higher loses" do
    player1, player2 = 1600, 1500

    it "should assign the correct number of points
      to the winner if 1 wins" do
      new_scores = Artist.assign_elo_points({winner: player2, loser: player1})
      expect(new_scores[:loser]).to eq 1580
    end
    it "should assign the correct number of points
      to the loser" do
      new_scores = Artist.assign_elo_points({winner: player2, loser: player1})
      expect(new_scores[:winner]).to eq 1520
    end
  end

  describe "#score" do
    it "should return a hash with keys of artist id's" do
      artist_elo_hash = Artist.score
      expect(artist_elo_hash.keys.first).to be > 0
    end

    it "should return a hash with values of elo scores" do
      artist_elo_hash = Artist.score
      expect(artist_elo_hash.values.sample).to be > 800
      expect(artist_elo_hash.values.sample).to be < 3000
    end

  end

  describe "#get_random_artist" do
    it "should return a random artist" do
      expect(Artist.get_random_artist).to be_an(Artist)
    end
  end

  describe "#format_artist_name_for_url" do
    it "should return a lowercase band name" do
      basic_artist = Artist.new(name:"Nas")
      expect(basic_artist.format_artist_name_for_url).to eq("nas")
    end

    it "should return a lowercase band name with no spaces" do
      spaced_artist = Artist.new(name:"Guided By Voices")
      expect(spaced_artist.format_artist_name_for_url).to eq("guided+by+voices")
    end

    it "should return a lowercase band name that formats ampersands correctly" do
      ampersand_artist = Artist.new(name:"Hall & Oates")
      expect(ampersand_artist.format_artist_name_for_url).to eq("hall+%26+oates")
    end

    it "should return a lowercase band name that formats plus signs correctly" do
      plus_artist = Artist.new(name:"Florence + The Machine")
      expect(plus_artist.format_artist_name_for_url).to eq('florence+%2B+the+machine')
    end

    it "should return a lowercase band name that formats hyphens correctly" do
      hyphen_artist = Artist.new(name:"Bone Thugs-N-Harmony")
      expect(hyphen_artist.format_artist_name_for_url).to eq("bone+thugs%2Dn%2Dharmony")
    end
    
  end

end
