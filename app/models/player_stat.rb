class PlayerStat < ApplicationRecord
  belongs_to :participation
  delegate :user, to: :participation, allow_nil: true, prefix: false

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

  attr_accessor :attempts, :actions

  # def player_participations(user)
  #   Participation.where(user: user)
  # end

  # def past_game(current_game, user)
  #   player_participations(user).where.not(id: current_game)
  # end



  # def complied_player_stats(game, user)
  #   past_games = past_game(game, user)

  #   reduced_player_stats = {
  #     minute: 0,
  #     rebound: 0,
  #     assist: 0,
  #     steal: 0,
  #     block: 0,
  #     fg_made: 0,
  #     fg_attempt: 0,
  #     threep_made: 0,
  #     threep_attempt: 0,
  #     ft_made: 0,
  #     ft_attempt: 0,
  #     off_rebound: 0,
  #     def_rebound: 0,
  #     turnover: 0,
  #     fault: 0,
  #     eval_player: 0
  #   }
  #   past_games.each do |past_g|
  #     past_g.game_player_stats.each_key do |key|
  #       if reduced_player_stats.key?(key)
  #         reduced_player_stats[key] += past_g.game_player_stats[key]
  #       end
  #     end
  #   end
  #   count = past_games.count
  #   reduced_player_stats.merge(eval_mean: count > 0 ? reduced_player_stats[:eval_player] / count : 0)
  # end

  # # def mean_player_stats
  # #   player__stat = total_team_stats(game)
  # #   total_past_game = past_game(game).count
  # #   total_team_stat.transform_values! { |stat| stat.to_f / total_past_game }

  # #   total_team_stat
  # # end

  def player
    last_name = user.name.split(', ').first
    first_name = "#{user.name.split(', ').last[0]}."
    [last_name, first_name].join(' ')
  end

  def eval_player
    ( point + off_rebound + def_rebound +  assist + steal + block ) - ( fg_attempt - fg_made - ft_attempt - ft_made - turnover )
  end

  def rebound
    off_rebound + def_rebound
  end

end
