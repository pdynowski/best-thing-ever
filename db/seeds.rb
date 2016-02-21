# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'net/http'
require 'json'
require 'faker'

(0..9).each do |count|
  url = "http://developer.echonest.com/api/v4/artist/search?api_key=#{Rails.application.secrets.echonest_api_key}&format=json&start=#{count * 100}&results=100&sort=familiarity-desc"
  uri = URI(url)
  data = Net::HTTP.get(uri)
  parsed = JSON.parse(data)
  parsed["response"]["artists"].each do |artist|
    Artist.create!(name: artist["name"], elo_score: 1500)
  end
end

User.create!(username: "test", email: "test@test.com", password: "test")

(0..100).each do |num|
  Vote.create!(user_id: 1, winner_id: rand(1..500), loser_id: rand(501..1000))
end

(0..50).each do 
  User.create!(username:Faker::Internet.user_name , email: Faker::Internet.email, password: "test")
end