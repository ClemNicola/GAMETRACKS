class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :managed_teams, class_name: :Team, foreign_key: :coach_id
  has_many :team_players
  has_many :teams, through: :team_players
  has_many :participations
  has_many :games, through: :participations

  validates :category, presence: true, inclusion: { in: %w[Coach Player Spectator] }
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :name, presence: true

  def player_name
    last_name = name.split(', ').first
    first_name = "#{name.split(', ').last[0]}."
    [last_name, first_name].join(' ')
  end

  def player_name_full
    last_name = name.split(', ').first
    first_name = name.split(', ').last
    [first_name, last_name].join(' ')
  end

  def size_cm
    cm = height.fdiv(100)
    size = "#{cm} m"
  end
end
