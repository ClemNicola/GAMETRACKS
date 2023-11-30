class Game < ApplicationRecord
  # has_one :winner, class_name: :Team, foreign_key: :team_id
  # has_many :game_stats
  has_many :participations
  has_many :teams, -> { distinct }, through: :participations
  has_many :players, through: :participations, source: :user

  validates :date,
            :time,
            :arena,
            :arena_address, presence: true

  def home_team
    teams.joins(:participations).where(participations: { home?: true }).distinct.first
  end

  def home_team_stats
    Participation.where(game: self, team: home_team).map(&:player_stat)
  end

  def away_team
    teams.joins(:participations).where(participations: { home?: false }).distinct.first
  end

  def away_team_stats
    Participation.where(game: self, team: away_team).map(&:player_stat)
  end
end
