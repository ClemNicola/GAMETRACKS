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
end
