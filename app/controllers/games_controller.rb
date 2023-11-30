class GamesController < ApplicationController
  before_action :set_player, only: [:show]

  def stats
    @game = Game.find(params[:id])
    @home_team_stats = @game.home_team_stats
  end

  def show
  end

  def index
    @games = []
    current_user.managed_teams.each do |team|
      @games << team.games
    end
    @games = @games.flatten
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
