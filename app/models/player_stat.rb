class PlayerStat < ApplicationRecord
  belongs_to :participation
  belongs_to :player, through: :participations, source: :user
  belongs_to :game_stat, through: :participations

  validates :minute, numericality: { only_integer: true }
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
