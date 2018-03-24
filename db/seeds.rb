# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'uri'
require 'score_generator'

uri = URI.parse('https://randomuser.me/api/?results=20')
response = Net::HTTP.get_response(uri)

JSON.parse(response.body)['results'].each do |user|
  first = user.dig('name', 'first').capitalize
  last = user.dig('name', 'last').capitalize
  User.create(name: "#{first} #{last}" ,
              avatar: user.dig('picture', 'large'))
end

ScoreGenerator.new(100).generate
