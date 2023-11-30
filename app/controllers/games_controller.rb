class GamesController < ApplicationController
  before_action :set_game, only: [:show]

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
