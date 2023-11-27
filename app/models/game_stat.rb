class GameStat < ApplicationRecord
  belongs_to :game
  has_many :teams
  has_many :users, through: :teams
  has_many :players_stat, through: :games
  belongs_to :team_stats, through: :teams

  validates :point, numericality: { only_integer: true }
  validates :fg_made, numericality: { only_integer: true }
  validates :fg_attempt, numericality: { only_integer: true }
  validates :threep_made, numericality: { only_integer: true }
  validates :threep_attempt, numericality: { only_integer: true }
  validates :ft_made, numericality: { only_integer: true }
  validates :ft_attempt, numericality: { only_integer: true }
  validates :off_rebound, numericality: { only_integer: true }
  validates :def_rebound, numericality: { only_integer: true }
  validates :assist, numericality: { only_integer: true }
  validates :turnover, numericality: { only_integer: true }
  validates :steal, numericality: { only_integer: true }
  validates :block, numericality: { only_integer: true }
  validates :fault, numericality: { only_integer: true }
  validates :evaluation, numericality: { only_integer: true }
end
