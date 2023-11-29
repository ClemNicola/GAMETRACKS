class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :managed_teams, class_name: :Team, foreign_key: :coach_id
  # belongs_to :teams, class_name: :Team, foreign_key: :player_id
  has_many :team_players
  has_many :teams, through: :team_players
  has_many :participations
  has_many :games, through: :participations

  # validates :category, presence: true, inclusion: { in: %w[Coach Player Spectator],
  #                                                   message: "This is not a valid category" }
  # validates :email, uniqueness: true
  # validates :name,
  #           :date_of_birth, presence: true
end
