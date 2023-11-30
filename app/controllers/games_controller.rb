class GamesController < ApplicationController

  def stats
    @game = Game.find(params[:id])
    @home_team_stats = @game.home_team_stats
  end
end
