class GamesController < ApplicationController
  before_action :set_game, only: [:play, :show, :set_participations]

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

  def play
    # @my_players = @game.participations.where(team_id: current_user.teams.first.id, selected: true).map(&:user)  RECUPERER LES JOUEURS EN JEU
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def participation_params
    params.permit(players: [])
  end
end
