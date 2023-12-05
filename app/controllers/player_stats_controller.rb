class PlayerStatsController < ApplicationController

  def new
    @game = Game.find(params[:id])
    @skip_navbar = true
    @skip_footer = true
    @playerstat = PlayerStat.new
  end

  def create
    @game = Game.find(player_stat_params[:game_id])
    clone = player_stat_params.clone
    clone.delete(:game_id)
    @player_stat = PlayerStat.new(clone)
    if @player_stat.save
      redirect_to play_game_path(@game)
    end
  end

  private

  def player_stat_params
    params.require(:player_stat).permit(:point, :fault, :ft_made, :fg_made, :threep_made, :ft_attempt, :fg_attempt, :threep_attempt, :block, :turnover, :steal, :assist, :off_rebound, :def_rebound, :participation_id, :game_id)
  end
end
