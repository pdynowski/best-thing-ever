require 'rails_helper'
require 'spec_helper'
describe Artist do
  it {should validate_presence_of :name}
  it {should validate_presence_of :elo_score }
  it {should have_many(:winning_votes).class_name("Vote")}
  it {should have_many(:losing_votes).class_name("Vote")}
end
