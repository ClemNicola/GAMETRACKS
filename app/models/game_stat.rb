class GameStat < ApplicationRecord
  belongs_to :game
  has_many :teams
  has_many :users, through: :teams
  has_many :players_stat, through: :games

  validates :point,
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
