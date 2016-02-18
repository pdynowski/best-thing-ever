# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Artist.create!(name: "Stevie Wonder", elo_score: 1500)
Artist.create!(name: "Radiohead", elo_score: 1500)
Artist.create!(name: "The Beatles", elo_score: 1500)
Artist.create!(name: "David Bowie", elo_score: 1500)
Artist.create!(name: "The Rolling Stones", elo_score: 1500)
Artist.create!(name: "Steely Dan", elo_score: 1500)
Artist.create!(name: "Sufjan Stevens", elo_score: 1500)
Artist.create!(name: "Prince", elo_score: 1500)
Artist.create!(name: "Guided By Voices", elo_score: 1500)
Artist.create!(name: "Beyonce", elo_score: 1500)

Vote.create!(winner_id: 1, loser_id: 3)
Vote.create!(winner_id: 1, loser_id: 4)
Vote.create!(winner_id: 4, loser_id: 9)
Vote.create!(winner_id: 5, loser_id: 6)
Vote.create!(winner_id: 4, loser_id: 2)
Vote.create!(winner_id: 4, loser_id: 7)
Vote.create!(winner_id: 7, loser_id: 5)
Vote.create!(winner_id: 1, loser_id: 2)
Vote.create!(winner_id: 9, loser_id: 2)
Vote.create!(winner_id: 8, loser_id: 7)
