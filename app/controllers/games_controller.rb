class GamesController < ApplicationController
  before_action :set_game, only: [:show, :set_participations]

  def stats
    @game = Game.find(params[:id])
    @home_team_stats = @game.home_team_stats
    home_stats = @game.home_stats_for_chart
    total_team_stats = @game.home_team.total_team_stats_for_chart(@game)

    render json: { home_stats: home_stats, total_team_stats: total_team_stats }
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

  def set_participations
    participations = []
    participation_params[:players].each do |user_id|
      team_id = User.find(user_id).teams.first.id
      new_participation = Participation.new(team_id: team_id, user_id: user_id, game_id: @game.id)

      participations << new_participation
    end
    success = participations.all?(&:save)

    if success
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def participation_params
    params.permit(players: [])
  end
end
