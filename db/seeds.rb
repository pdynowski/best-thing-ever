# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'net/http'
require 'json'

(0..9).each do |count|
  url = "http://developer.echonest.com/api/v4/artist/search?api_key=#{Rails.application.secrets.echonest_api_key}&format=json&start=#{count * 100}&results=100&sort=familiarity-desc"
  puts "URL -----------------------------> #{url}"
  uri = URI(url)
  data = Net::HTTP.get(uri)
  parsed = JSON.parse(data)
  parsed["response"]["artists"].each do |artist|
    Artist.create!(name: artist["name"], elo_score: 1500)
  end
end

Vote.create!(winner_id: 1, loser_id: 2)
