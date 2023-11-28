require 'faker'
require 'date'
require 'open-uri'

puts 'Destroy all the existing data'
Participation.destroy_all
GameStat.destroy_all
Game.destroy_all
PlayerStat.destroy_all
TeamPlayer.destroy_all
TeamStat.destroy_all
Team.destroy_all
User.destroy_all

coach_alex = User.create(
  email: "alexis@test.com",
  password: "123456",
  category: "Coach",
  name: "Alexis K Dutoya",
  date_of_birth: Date.new(1995, 12, 12),
  license_id: "VT123456",
  phone: "0611223344"
)

coach_pierre = User.create(
  email: "pierre@test.com",
  password: "123456",
  category: "Coach",
  name: "Pierre Briseur de Cercle Eloy",
  date_of_birth: Date.new(1991, 2, 8),
  license_id: "VT910263",
  phone: "0699887766"
)

coach_clement = User.create(
  email: "clement@test.com",
  password: "123456",
  category: "Coach",
  name: "Clément ChessBoy Nicolas",
  date_of_birth: Date.new(1999, 6, 4),
  license_id: "VT314798",
  phone: "0671829304"
)

coach_abdes = User.create(
  email: "abdes@test.com",
  password: "123456",
  category: "Coach",
  name: "Abdes Cat Sefrioui",
  date_of_birth: Date.new(1997, 11, 1),
  license_id: "VT098342",
  phone: "0691824758"
)

puts "Creating 5 games"

5.times do
game = Game.create(
  date: Date.new(2023, rand(10..12), rand(1..30)),
  time: "#{rand(10..22)}:00",
  arena: ["Palais des Sports", "Bercy", "Adidas Arena"].sample,
  arena_address: Faker::Address.street_address
)
puts "#{game.date} created"
end

api_key = 'gty53tnwetmr2cau5sn8k24z'
season_id = "sr:season:108153" #PRO A 2023-2024 - Season Info id competition : "sr:competition:156"

# Liste des équipes dans ce championnat
competition_url_api = "https://api.sportradar.com/basketball/trial/v2/en/seasons/#{season_id}/competitors.json?api_key=#{api_key}"

json_parsed = JSON.parse(URI.open(competition_url_api).read)

# On va chercher la data des équipes générées
json_parsed["season_competitors"].take(6).each do |team|
  p team_id = team["id"]
  team = Team.create(
    club_name: team["name"],
    age_level: "Seniors",
    category: "PRO A",
    city: team["short_name"],
    coach_id: [coach_alex.id, coach_abdes.id, coach_clement.id, coach_pierre.id].sample
  )

  puts "#{team.club_name} #{team.city} created"

  p team_url = "https://api.sportradar.com/basketball/trial/v2/en/competitors/#{team_id}/profile.json?api_key=#{api_key}"
  team_json_parsed = JSON.parse(URI.open(team_url).read)
  # On va chercher la data de chaque joueur de chaque équipe générée
  team_json_parsed["players"].take(2).each do |player|
    player = User.create(
      email: Faker::Internet.email,
      password: "123456",
      category: "Player",
      name: player["name"],
      date_of_birth: player["date_of_birth"],
      license_id: Faker::IDNumber.french_insee_number,
      phone: Faker::PhoneNumber.phone_number,
      sex: "Male",
      description: Faker::ChuckNorris.fact,
      position: player["type"],
      height: player["height"]
    )
    puts "#{player.name} created"

    teamplayer = TeamPlayer.create(
      user_id: player.id,
      team_id: team.id
    )
    p teamplayer
  end
end

my_team = Team.first
other_teams = Team.where.not(id: my_team)

Game.all.each do |game|
  home = [true, false].sample

  my_team.players.each do |player|
    Participation.create(
      team: player.teams.first,
      user: player,
      game: game,
      home?: home
    )
  end
end

index = 0

Game.all.each do |game|
  break if other_teams.count == index

  home = !game.teams.first.participations.first.home?

  puts "Creating participation for team #{index}"

  other_teams[index].players.each do |player|
    Participation.create(
      team: player.teams.first,
      user: player,
      game: game,
      home?: home
    )
  end

  index += 1
end
