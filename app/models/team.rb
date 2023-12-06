class Team < ApplicationRecord
  belongs_to :coach, class_name: :User, foreign_key: :coach_id
  has_many :participations
  has_many :games, -> { distinct }, through: :participations
  has_many :game_stats
  has_one :team_stat
  has_many :team_players
  has_many :players, through: :team_players, source: :player
  has_one_attached :photo

  after_create :add_team_stat

  # validates :club_name,
  #           :age_level,
  #           :category,
  #           :city, presence: true

  def past_game(current_game)

    ## WARNING

    games.where.not(id: current_game)
    # Game.all
  end

  def compiled_team_stats(game)
    reduced_team_stats = {
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
   past_game(game).each do |past_g|
      past_g.compiled_home_stats.each_key do |key|
        next if key == :eval_mean
        reduced_team_stats[key] += past_g.compiled_home_stats[key]
      end
    end
    reduced_team_stats.merge(eval_mean: reduced_team_stats[:eval_player] / past_game(game).count)
  end

  def total_team_stats(game)
    outputs = %i(point assist off_rebound def_rebound turnover)
    team_stats = compiled_team_stats(game)
    t_stats = {}
    outputs.each do |output|
      t_stats[output] = team_stats[output]
    end
    t_stats
  end

  def total_team_stats_for_chart(game)
    total_team_stat = total_team_stats(game)
    total_past_game = past_game(game).count
    total_team_stat.transform_values! { |stat| stat.to_f / total_past_game }

    total_team_stat
  end

  def update_team_stat(game)
    stats = game.compiled_home_stats

    attributes = {
      total_wins: game.winner_id == id ? team_stat.total_wins += 1 : team_stat.total_wins,
      total_losses: game.winner_id == id ? team_stat.total_losses : team_stat.total_losses += 1,
      total_point: team_stat.total_point + stats[:point],
      total_assist: team_stat.total_assist + stats[:assist],
      total_steal: team_stat.total_steal + stats[:steal],
      total_block: team_stat.total_block + stats[:block],
      total_fg_made: team_stat.total_fg_made + stats[:fg_made],
      total_fg_attempt: team_stat.total_fg_attempt + stats[:fg_attempt],
      total_threep_made: team_stat.total_threep_made + stats[:threep_made],
      total_threep_attempt: team_stat.total_threep_attempt + stats[:threep_attempt],
      total_ft_made: team_stat.total_ft_made + stats[:ft_made],
      total_ft_attempt: team_stat.total_ft_attempt + stats[:ft_attempt],
      total_off_rebound: team_stat.total_off_rebound + stats[:off_rebound],
      total_def_rebound: team_stat.total_def_rebound + stats[:def_rebound],
      total_turnover: team_stat.total_turnover + stats[:turnover],
      total_fault: team_stat.total_fault + stats[:fault]
    }

    TeamStat.update(attributes)
  end

  # private

  def add_team_stat
    attributes = {
      total_wins: 0,
      total_losses: 0,
      total_point: 0,
      total_assist: 0,
      total_steal: 0,
      total_block: 0,
      total_fg_made: 0,
      total_fg_attempt: 0,
      total_threep_made: 0,
      total_threep_attempt: 0,
      total_ft_made: 0,
      total_ft_attempt: 0,
      total_off_rebound: 0,
      total_def_rebound: 0,
      total_turnover: 0,
      total_fault: 0,
      total_evaluation: 0,
      team: self
    }

    TeamStat.create(attributes)
  end

  def rebound
    total_off_rebound + total_def_rebound
  end
end
