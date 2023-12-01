class PlayerStatsController < ApplicationController

  def new
    @game = Game.find(params[:id])
    @skip_navbar = true
    @skip_footer = true
    @playerstat = PlayerStat.new
  end

  def create
  end
end
