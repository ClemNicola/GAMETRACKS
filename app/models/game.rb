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

  def compiled_home_stats
    reduced_stats = {
      point: 0,
      rebound: 0,
      assist: 0,
      steal: 0,
      block: 0,
      fg_made: 0,
      fg_attempt: 0,
      threep_made: 0,
      threep_attempt: 0,
      ft_made: 0,
      ft_attempt: 0,
      off_rebound: 0,
      def_rebound: 0,
      turnover: 0,
      fault: 0,
      eval_player: 0
    }
    home_team_stats.compact.each do |stat|
      reduced_stats.keys.each do |key|
        reduced_stats[key] += stat.send(key)
      end
    end

    reduced_stats.merge(eval_mean: reduced_stats[:eval_player] / home_team_stats.count)
  end

  def home_stats_for_chart
    outputs = %i(point assist off_rebound def_rebound turnover)
    home_stats = compiled_home_stats
    stats = {}
    outputs.each do |output|
      stats[output] = home_stats[output]
    end
    stats
  end

  def total_home_stats
    stat_values = home_stats_for_chart.values
    stat_team = stat_values[0...-1]
    mean_stat_team = stat_team.sum.to_f / stat_team.length
  end

  def away_team
    teams.joins(:participations).where(participations: { home?: false }).distinct.first
  end

  def away_team_stats
    Participation.where(game: self, team: away_team).map(&:player_stat)
  end

end
