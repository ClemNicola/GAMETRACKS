class TeamStat < ApplicationRecord
  belongs_to :team
  has_many :game_stats, through: :teams

  validates :total_wins, numericality: { only_integer: true }
  validates :total_losses, numericality: { only_integer: true }
  validates :total_point, numericality: { only_integer: true }
  validates :total_fg_made, numericality: { only_integer: true }
  validates :total_fg_attempt, numericality: { only_integer: true }
  validates :total_threep_made, numericality: { only_integer: true }
  validates :total_threep_attempt, numericality: { only_integer: true }
  validates :total_ft_made, numericality: { only_integer: true }
  validates :total_ft_attempt, numericality: { only_integer: true }
  validates :total_off_rebound, numericality: { only_integer: true }
  validates :total_def_rebound, numericality: { only_integer: true }
  validates :total_assist, numericality: { only_integer: true }
  validates :total_turnover, numericality: { only_integer: true }
  validates :total_steal, numericality: { only_integer: true }
  validates :total_block, numericality: { only_integer: true }
  validates :total_fault, numericality: { only_integer: true }
  validates :total_evaluation, numericality: { only_integer: true }
end
