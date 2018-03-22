# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'uri'

uri = URI.parse('https://randomuser.me/api/?results=20')
response = Net::HTTP.get_response(uri)

JSON.parse(response.body)['results'].each do |user|
  User.create(name: user.dig('name', 'first'),
              avatar: user.dig('picture', 'medium'))
end

30.times do |i|
  user_id = rand(20) + 1
  user = User.find(user_id)

  modifier = (rand(3) - 1)
  value = rand(1000) * modifier
  value /= 3 if modifier < 0

  Score.create(user: user, value: value) unless value.zero?
end
