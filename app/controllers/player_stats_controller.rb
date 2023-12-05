class PlayerStatsController < ApplicationController

  def new
    @game = Game.find(params[:game_id])
    @skip_navbar = true
    @skip_footer = true
    # @participation = current_user.participations.find_by(game_id: @game.id)
    # @player_stat = @participation.player_stats
    @playerstat = PlayerStat.new
  end

  def create
  end

  private
  def player_stat_params
    params.require(:player_stat).permit(:point, :assist, :off_rebond, :def_rebound, :turnover, :block, :fault, :participation_id)
  end
end
