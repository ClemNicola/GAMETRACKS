class Team < ApplicationRecord
  belongs_to :coach, class_name: :User, foreign_key: :coach_id
  # has_many :players, class_name: :User, foreign_key: :player_id
  has_many :participations
  has_many :games, through: :participations
  has_many :game_stats
  has_one :team_stats
  has_many :team_players
  has_many :players, through: :team_players, source: :player

  validates :club_name, presence: true
  validates :age_level, presence: true
  validates :category, presence: true
  validates :city, presence: true
end
