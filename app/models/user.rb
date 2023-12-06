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
  has_many :player_stats

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

  def player_stat_for_game(game)
   participation = participations.find_by(game: game).player_stat
   stats = participation.slice(:minute, :point, :rebound, :assist, :off_rebound, :def_rebound, :block, :turnover, :eval_player)
   stats[:rebound] = stats[:off_rebound] + stats[:def_rebound]
   stats
  end

  # def player_participations(user)
  #   Participation.where(user: user)
  # end

  def past_game(game)
    participations.where.not(game: game)
  end

  def past_game_stats(game)
    past_game(game).extract_associated(:player_stat)
  end


  def compiled_player_stats(game)
    stat = past_game_stats(game)
    reduced_player_stats = {
      minute: stat.sum(&:minute),
      point: stat.sum(&:point),
      rebound: stat.sum(&:off_rebound) + stat.sum(&:def_rebound),
      assist: stat.sum(&:assist),
      steal: stat.sum(&:steal),
      block: stat.sum(&:block),
      fg_made: stat.sum(&:fg_made),
      fg_attempt: stat.sum(&:fg_attempt),
      fg_pct: stat.sum(&:fg_made) / stat.sum(&:fg_attempt) * 100,
      threep_made: stat.sum(&:threep_made),
      threep_attempt: stat.sum(&:threep_attempt),
      ft_made: stat.sum(&:ft_made),
      ft_attempt: stat.sum(&:ft_attempt),
      ft_pct: stat.sum(&:ft_made) / stat.sum(&:ft_attempt) * 100,
      off_rebound: stat.sum(&:off_rebound),
      def_rebound: stat.sum(&:def_rebound),
      turnover: stat.sum(&:turnover),
      fault: stat.sum(&:fault),
      eval_player: stat.sum(&:eval_player) / stat.count
    }
  end

  def mean_player_stats(game)
    total_player_stats = compiled_player_stats(game)
    total_past_game = past_game(game).count
    total_player_stats.transform_values! { |stat| stat.to_f / total_past_game }
    total_player_stats.slice(:minute, :point, :rebound, :assist, :fg_made, :ft_made, :threep_made, :off_rebound, :def_rebound, :block, :turnover, :eval_player)
  end

  def radar_total_stats(game)
    mean_player_stats(game).except(:minute, :off_rebound, :def_rebound, :eval_player, :fg_made, :ft_made, :threep_made)
  end

  def player
    last_name = user.name.split(', ').first
    first_name = "#{user.name.split(', ').last[0]}."
    [last_name, first_name].join(' ')
  end
end
