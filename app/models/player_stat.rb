class PlayerStat < ApplicationRecord
  belongs_to :participation
  belongs_to :player, through: :participations, source: :user
  belongs_to :game_stat, through: :participations

  validates :minute,
            :point,
            :fg_made,
            :fg_attempt,
            :threep_made,
            :threep_attempt,
            :ft_made,
            :ft_attempt,
            :off_rebound,
            :def_rebound,
            :assist,
            :turnover,
            :steal,
            :block,
            :fault,
            :evaluation, numericality: { only_integer: true }
end
