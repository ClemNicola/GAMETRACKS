class TeamStat < ApplicationRecord
  belongs_to :team
  has_many :game_stats, through: :teams

  validates :total_wins,
            :total_losses,
            :total_point,
            :total_fg_made,
            :total_fg_attempt,
            :total_threep_made,
            :total_threep_attempt,
            :total_ft_made,
            :total_ft_attempt,
            :total_off_rebound,
            :total_def_rebound,
            :total_assist,
            :total_turnover,
            :total_steal,
            :total_block,
            :total_fault,
            presence: true


  # def total_team_stats
  #   Team.where(team: team_id)
  #       .where.not(id: current_game_id)
  #       .map(&:team_stat)
  # end


end
