require 'faker'
require 'date'
require 'open-uri'

puts 'Destroy all the existing data'
PlayerStat.destroy_all
Participation.destroy_all
GameStat.destroy_all
Game.destroy_all
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
p "Alexis is a coach"

coach_pierre = User.create(
  email: "pierre@test.com",
  password: "123456",
  category: "Coach",
  name: "Pierre Briseur de Cercle Eloy",
  date_of_birth: Date.new(1991, 2, 8),
  license_id: "VT910263",
  phone: "0699887766"
)
p "Pierre is a coach"

coach_clement = User.create(
  email: "clement@test.com",
  password: "123456",
  category: "Coach",
  name: "Clément ChessBoy Nicolas",
  date_of_birth: Date.new(1999, 6, 4),
  license_id: "VT314798",
  phone: "0671829304"
)
p "Clement is a coach"

coach_abdes = User.create(
  email: "abdes@test.com",
  password: "123456",
  category: "Coach",
  name: "Abdes Cat Sefrioui",
  date_of_birth: Date.new(1997, 11, 1),
  license_id: "VT098342",
  phone: "0691824758"
)
p "Abdes is a coach"

puts "Creating 3 games"

6.times do
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
json_parsed["season_competitors"].take(4).each do |team|
  p team_id = team["id"]
  team = Team.create(
    club_name: team["name"],
    age_level: "Seniors",
    category: "PRO A",
    city: team["short_name"],
    coach_id: [coach_alex.id, coach_abdes.id, coach_clement.id, coach_pierre.id].pop
  )

  puts "#{team.club_name} #{team.city} created"

  p team_url = "https://api.sportradar.com/basketball/trial/v2/en/competitors/#{team_id}/profile.json?api_key=#{api_key}"
  team_json_parsed = JSON.parse(URI.open(team_url).read)
  # On va chercher la data de chaque joueur de chaque équipe générée
  team_json_parsed["players"].take(11).each do |player|
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

def stats(participation)
  [
    [
      { minute: 30, point: 11, fg_made: 2, fg_attempt: 4, threep_made: 2, threep_attempt: 5, ft_made: 1, ft_attempt: 3, off_rebound: 0, def_rebound: 1, assist: 1, turnover: 2, steal: 4, block: 8, fault: 3, evaluation: 7, participation: participation },
      { minute: 27, point: 16, fg_made: 6, fg_attempt: 8, threep_made: 1, threep_attempt: 2, ft_made: 1, ft_attempt: 4, off_rebound: 0, def_rebound: 7, assist: 1, turnover: 3, steal: 0, block: 1, fault: 3, evaluation: 18, participation: participation },
      { minute: 31, point: 20, fg_made: 6, fg_attempt: 7, threep_made: 2, threep_attempt: 3, ft_made: 2, ft_attempt: 3, off_rebound: 0, def_rebound: 6, assist: 9, turnover: 0, steal: 4, block: 2, fault: 2, evaluation: 29, participation: participation },
      { minute: 19, point: 10, fg_made: 5, fg_attempt: 8, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 1, def_rebound: 6, assist: 0, turnover: 1, steal: 1, block: 2, fault: 1, evaluation: 13, participation: participation },
      { minute: 24, point: 5, fg_made: 0, fg_attempt: 1, threep_made: 1, threep_attempt: 3, ft_made: 2, ft_attempt: 2, off_rebound: 0, def_rebound: 1, assist: 4, turnover: 0, steal: 0, block: 0, fault: 2, evaluation: 7, participation: participation },
      { minute: 22, point: 12, fg_made: 0, fg_attempt: 3, threep_made: 4, threep_attempt: 4, ft_made: 0, ft_attempt: 0, off_rebound: 1, def_rebound: 0, assist: 1, turnover: 3, steal: 4, block: 0, fault: 4, evaluation: 9, participation: participation },
      { minute: 21, point: 2, fg_made: 1, fg_attempt: 2, threep_made: 0, threep_attempt: 2, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 2, assist: 3, turnover: 1, steal: 0, block: 1, fault: 2, evaluation: 4, participation: participation },
      { minute: 11, point: 1, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 1, ft_attempt: 2, off_rebound: 1, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 1, evaluation: 6, participation: participation },
      { minute: 11, point: 8, fg_made: 1, fg_attempt: 1, threep_made: 1, threep_attempt: 1, ft_made: 3, ft_attempt: 4, off_rebound: 0, def_rebound: 2, assist: 2, turnover: 2, steal: 1, block: 2, fault: 1, evaluation: 12, participation: participation },
      { minute: 4, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 1, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: -1, participation: participation },
      { minute: 0, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: 0, participation: participation }
    ],
    [
      { minute: 13, point: 4, fg_made: 1, fg_attempt: 3, threep_made: 0, threep_attempt: 3, ft_made: 2, ft_attempt: 2, off_rebound: 1, def_rebound: 0, assist: 0, turnover: 2, steal: 2, block: 0, fault: 2, evaluation: 0, participation: participation },
      { minute: 29, point: 14, fg_made: 5, fg_attempt: 9, threep_made: 1, threep_attempt: 4, ft_made: 1, ft_attempt: 2, off_rebound: 2, def_rebound: 5, assist: 7, turnover: 2, steal: 2, block: 0, fault: 4, evaluation: 15, participation: participation },
      { minute: 13, point: 1, fg_made: 0, fg_attempt: 1, threep_made: 0, threep_attempt: 0, ft_made: 1, ft_attempt: 2, off_rebound: 2, def_rebound: 1, assist: 3, turnover: 0, steal: 0, block: 0, fault: 2, evaluation: 3, participation: participation },
      { minute: 28, point: 20, fg_made: 5, fg_attempt: 10, threep_made: 3, threep_attempt: 6, ft_made: 1, ft_attempt: 2, off_rebound: 0, def_rebound: 2, assist: 2, turnover: 1, steal: 1, block: 2, fault: 2, evaluation: 18, participation: participation },
      { minute: 18, point: 6, fg_made: 2, fg_attempt: 2, threep_made: 0, threep_attempt: 0, ft_made: 2, ft_attempt: 4, off_rebound: 1, def_rebound: 2, assist: 0, turnover: 0, steal: 0, block: 0, fault: 1, evaluation: 8, participation: participation },
      { minute: 30, point: 10, fg_made: 1, fg_attempt: 2, threep_made: 1, threep_attempt: 6, ft_made: 5, ft_attempt: 6, off_rebound: 1, def_rebound: 3, assist: 0, turnover: 2, steal: 1, block: 4, fault: 4, evaluation: 9, participation: participation },
      { minute: 26, point: 11, fg_made: 5, fg_attempt: 10, threep_made: 0, threep_attempt: 4, ft_made: 1, ft_attempt: 2, off_rebound: 5, def_rebound: 9, assist: 14, turnover: 1, steal: 0, block: 1, fault: 4, evaluation: 17, participation: participation },
      { minute: 18, point: 0, fg_made: 0, fg_attempt: 1, threep_made: 0, threep_attempt: 1, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 1, assist: 1, turnover: 0, steal: 0, block: 1, fault: 1, evaluation: 3, participation: participation },
      { minute: 17, point: 11, fg_made: 1, fg_attempt: 1, threep_made: 3, threep_attempt: 5, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 2, steal: 1, block: 2, fault: 1, evaluation: 10, participation: participation },
      { minute: 7, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 3, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 1, evaluation: 0, participation: participation },
      { minute: 0, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: 0, participation: participation }
    ],
    [
      { minute: 30, point: 11, fg_made: 2, fg_attempt: 4, threep_made: 2, threep_attempt: 5, ft_made: 1, ft_attempt: 3, off_rebound: 0, def_rebound: 1, assist: 1, turnover: 2, steal: 4, block: 8, fault: 3, evaluation: 3, participation: participation },
      { minute: 27, point: 16, fg_made: 6, fg_attempt: 8, threep_made: 1, threep_attempt: 2, ft_made: 1, ft_attempt: 4, off_rebound: 7, def_rebound: 0, assist: 3, turnover: 1, steal: 0, block: 18, fault: 1, evaluation: 7, participation: participation },
      { minute: 31, point: 20, fg_made: 6, fg_attempt: 7, threep_made: 2, threep_attempt: 3, ft_made: 2, ft_attempt: 3, off_rebound: 6, def_rebound: 9, assist: 0, turnover: 2, steal: 2, block: 29, fault: 12, evaluation: 12, participation: participation },
      { minute: 19, point: 10, fg_made: 5, fg_attempt: 8, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 1, def_rebound: 6, assist: 1, turnover: 1, steal: 0, block: 1, fault: 2, evaluation: 7, participation: participation },
      { minute: 24, point: 5, fg_made: 0, fg_attempt: 1, threep_made: 1, threep_attempt: 3, ft_made: 2, ft_attempt: 2, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: 0, participation: participation },
      { minute: 22, point: 12, fg_made: 0, fg_attempt: 3, threep_made: 4, threep_attempt: 4, ft_made: 4, ft_attempt: 4, off_rebound: 1, def_rebound: 0, assist: 0, turnover: 2, steal: 1, block: 3, fault: 4, evaluation: 9, participation: participation },
      { minute: 21, point: 2, fg_made: 1, fg_attempt: 2, threep_made: 0, threep_attempt: 2, ft_made: 0, ft_attempt: 0, off_rebound: 1, def_rebound: 2, assist: 1, turnover: 3, steal: 1, block: 4, fault: 4, evaluation: 4, participation: participation },
      { minute: 11, point: 1, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 1, ft_attempt: 2, off_rebound: 0, def_rebound: 1, assist: 0, turnover: 1, steal: 1, block: 6, fault: 1, evaluation: -1, participation: participation },
      { minute: 11, point: 1, fg_made: 1, fg_attempt: 1, threep_made: 1, threep_attempt: 1, ft_made: 3, ft_attempt: 4, off_rebound: 0, def_rebound: 0, assist: 2, turnover: 2, steal: 2, block: 5, fault: 5, evaluation: 12, participation: participation },
      { minute: 4, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: -1, participation: participation },
      { minute: 0, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: 0, participation: participation }
    ],
    [
      { minute: 21, point: 6, fg_made: 2, fg_attempt: 5, threep_made: 0, threep_attempt: 0, ft_made: 2, ft_attempt: 4, off_rebound: 1, def_rebound: 2, assist: 3, turnover: 2, steal: 5, block: 5, fault: 8, evaluation: 5, participation: participation },
      { minute: 20, point: 8, fg_made: 1, fg_attempt: 3, threep_made: 1, threep_attempt: 2, ft_made: 3, ft_attempt: 3, off_rebound: 3, def_rebound: 4, assist: 3, turnover: 1, steal: 2, block: 15, fault: 7, evaluation: 7, participation: participation },
      { minute: 25, point: 14, fg_made: 1, fg_attempt: 1, threep_made: 4, threep_attempt: 5, ft_made: 0, ft_attempt: 1, off_rebound: 0, def_rebound: 0, assist: 4, turnover: 0, steal: 0, block: 4, fault: 5, evaluation: 17, participation: participation },
      { minute: 22, point: 12, fg_made: 5, fg_attempt: 6, threep_made: 0, threep_attempt: 0, ft_made: 2, ft_attempt: 3, off_rebound: 2, def_rebound: 3, assist: 0, turnover: 1, steal: 0, block: 4, fault: 15, evaluation: 2, participation: participation },
      { minute: 24, point: 16, fg_made: 4, fg_attempt: 7, threep_made: 2, threep_attempt: 5, ft_made: 2, ft_attempt: 2, off_rebound: 0, def_rebound: 3, assist: 2, turnover: 0, steal: 0, block: 0, fault: 2, evaluation: 15, participation: participation },
      { minute: 24, point: 13, fg_made: 4, fg_attempt: 5, threep_made: 1, threep_attempt: 2, ft_made: 2, ft_attempt: 3, off_rebound: 1, def_rebound: 0, assist: 0, turnover: 2, steal: 3, block: 1, fault: 3, evaluation: 18, participation: participation },
      { minute: 20, point: 9, fg_made: 0, fg_attempt: 2, threep_made: 2, threep_attempt: 3, ft_made: 3, ft_attempt: 4, off_rebound: 1, def_rebound: 2, assist: 2, turnover: 1, steal: 2, block: 2, fault: 2, evaluation: 8, participation: participation },
      { minute: 19, point: 8, fg_made: 1, fg_attempt: 1, threep_made: 2, threep_attempt: 6, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 4, assist: 0, turnover: 0, steal: 1, block: 0, fault: 2, evaluation: 9, participation: participation },
      { minute: 12, point: 7, fg_made: 2, fg_attempt: 5, threep_made: 0, threep_attempt: 0, ft_made: 3, ft_attempt: 4, off_rebound: 4, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 3, fault: 4, evaluation: 11, participation: participation },
      { minute: 7, point: 2, fg_made: 1, fg_attempt: 1, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 1, block: 0, fault: 0, evaluation: -1, participation: participation },
      { minute: 0, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: 0, participation: participation }
    ],
    [
      { minute: 31, point: 12, fg_made: 2, fg_attempt: 6, threep_made: 2, threep_attempt: 4, ft_made: 2, ft_attempt: 2, off_rebound: 0, def_rebound: 4, assist: 4, turnover: 0, steal: 0, block: 2, fault: 3, evaluation: 8, participation: participation },
      { minute: 24, point: 6, fg_made: 2, fg_attempt: 5, threep_made: 0, threep_attempt: 1, ft_made: 2, ft_attempt: 2, off_rebound: 1, def_rebound: 1, assist: 3, turnover: 0, steal: 0, block: 2, fault: 2, evaluation: 5, participation: participation },
      { minute: 28, point: 7, fg_made: 2, fg_attempt: 2, threep_made: 1, threep_attempt: 3, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 4, assist: 2, turnover: 0, steal: 0, block: 2, fault: 3, evaluation: 10, participation: participation },
      { minute: 33, point: 17, fg_made: 3, fg_attempt: 8, threep_made: 3, threep_attempt: 4, ft_made: 2, ft_attempt: 3, off_rebound: 2, def_rebound: 4, assist: 2, turnover: 0, steal: 1, block: 1, fault: 2, evaluation: 17, participation: participation },
      { minute: 21, point: 0, fg_made: 0, fg_attempt: 1, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 3, def_rebound: 2, assist: 0, turnover: 0, steal: 0, block: 0, fault: 6, evaluation: -16, participation: participation },
      { minute: 31, point: 11, fg_made: 1, fg_attempt: 4, threep_made: 3, threep_attempt: 9, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 4, assist: 2, turnover: 1, steal: 0, block: 0, fault: 2, evaluation: 9, participation: participation },
      { minute: 19, point: 12, fg_made: 5, fg_attempt: 6, threep_made: 0, threep_attempt: 0, ft_made: 2, ft_attempt: 3, off_rebound: 1, def_rebound: 3, assist: 0, turnover: 1, steal: 0, block: 0, fault: 2, evaluation: 15, participation: participation },
      { minute: 12, point: 1, fg_made: 0, fg_attempt: 1, threep_made: 0, threep_attempt: 1, ft_made: 1, ft_attempt: 2, off_rebound: 0, def_rebound: 0, assist: 6, turnover: 0, steal: 1, block: 0, fault: 1, evaluation: 3, participation: participation },
      { minute: 0, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: 0, participation: participation },
      { minute: 0, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: 0, participation: participation },
      { minute: 0, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: 0, participation: participation }
    ],
    [
      { minute: 25, point: 10, fg_made: 3, fg_attempt: 8, threep_made: 0, threep_attempt: 2, ft_made: 4, ft_attempt: 4, off_rebound: 0, def_rebound: 3, assist: 2, turnover: 2, steal: 3, block: 2, fault: 3, evaluation: 7, participation: participation },
      { minute: 30, point: 6, fg_made: 3, fg_attempt: 6, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 7, assist: 2, turnover: 3, steal: 0, block: 2, fault: 3, evaluation: 13, participation: participation },
      { minute: 20, point: 5, fg_made: 0, fg_attempt: 0, threep_made: 1, threep_attempt: 4, ft_made: 2, ft_attempt: 2, off_rebound: 2, def_rebound: 0, assist: 0, turnover: 0, steal: 1, block: 0, fault: 2, evaluation: 5, participation: participation },
      { minute: 20, point: 6, fg_made: 2, fg_attempt: 5, threep_made: 0, threep_attempt: 4, ft_made: 2, ft_attempt: 2, off_rebound: 0, def_rebound: 0, assist: 2, turnover: 0, steal: 0, block: 0, fault: 3, evaluation: -2, participation: participation },
      { minute: 32, point: 4, fg_made: 2, fg_attempt: 2, threep_made: 0, threep_attempt: 2, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 6, assist: 1, turnover: 0, steal: 0, block: 1, fault: 1, evaluation: 10, participation: participation },
      { minute: 25, point: 5, fg_made: 1, fg_attempt: 2, threep_made: 1, threep_attempt: 1, ft_made: 0, ft_attempt: 5, off_rebound: 3, def_rebound: 1, assist: 1, turnover: 1, steal: 0, block: 1, fault: 3, evaluation: -2, participation: participation },
      { minute: 20, point: 9, fg_made: 3, fg_attempt: 5, threep_made: 0, threep_attempt: 2, ft_made: 3, ft_attempt: 4, off_rebound: 1, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 2, fault: 3, evaluation: 5, participation: participation },
      { minute: 15, point: 11, fg_made: 4, fg_attempt: 5, threep_made: 1, threep_attempt: 1, ft_made: 1, ft_attempt: 1, off_rebound: 1, def_rebound: 1, assist: 1, turnover: 0, steal: 1, block: 0, fault: 3, evaluation: -9, participation: participation },
      { minute: 10, point: 3, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 1, ft_attempt: 1, off_rebound: 0, def_rebound: 1, assist: 0, turnover: 1, steal: 0, block: 0, fault: 2, evaluation: 2, participation: participation },
      { minute: 3, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 1, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 1, evaluation: -5, participation: participation },
      { minute: 0, point: 0, fg_made: 0, fg_attempt: 0, threep_made: 0, threep_attempt: 0, ft_made: 0, ft_attempt: 0, off_rebound: 0, def_rebound: 0, assist: 0, turnover: 0, steal: 0, block: 0, fault: 0, evaluation: 0, participation: participation },
    ]
  ]
end

i = 0
index = 0

count = 1

team = Team.first
game = team.games.first
participations = Participation.where(game: Game.all)

participations.each do |participation|
  break if participations.count == index

  stats_info = stats(participation)[i]

  stat_info = stats_info[index]

  stat = PlayerStat.create!(stat_info)
  index += 1

  puts "Player #{count} #{participation.user.name} played #{stat.minute} min"

  if count == stats_info.count
    i += 1
    count = 1
    index = 0
  else
    count += 1
  end
end
