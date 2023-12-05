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
  attribute :minute, :integer, default: 0
  attribute :point, :integer, default: 0
  attribute :fg_made, :integer, default: 0
  attribute :fg_attempt, :integer, default: 0
  attribute :threep_made, :integer, default: 0
  attribute :threep_attempt, :integer, default: 0
  attribute :ft_made, :integer, default: 0
  attribute :ft_attempt, :integer, default: 0
  attribute :off_rebound, :integer, default: 0
  attribute :def_rebound, :integer, default: 0
  attribute :assist, :integer, default: 0
  attribute :turnover, :integer, default: 0
  attribute :steal, :integer, default: 0
  attribute :block, :integer, default: 0
  attribute :fault, :integer, default: 0
  attribute :evaluation, :integer, default: 0
end
