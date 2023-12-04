class GamesController < ApplicationController
  before_action :set_game, only: [:play, :show, :set_participations]

  def stats
    @game = Game.find(params[:id])
    @home_team_stats = @game.home_team_stats
  end

  def show
    @team = Team.where(coach: current_user)
    @my_players = @team.first.players.where[selected: true].group_by(&:position)
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
      new_participation = Participation.new(team_id: team_id, user_id: user_id, game_id: @game.id, selected?: true)

      participations << new_participation
    end
    success = participations.all?(&:save)

    if success
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def play
    @my_players = @game.participations.where(team_id: current_user.teams.first.id, selected: true).map(&:user)
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def participation_params
    params.permit(:authenticity_token, :commit, :id, players: [])
  end
end
