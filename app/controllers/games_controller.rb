class GamesController < ApplicationController
  before_action :set_game, only: [:play, :show, :set_participations, :quarter_data, :total_quarter_data]

  def stats
    @game = Game.find(params[:id])
    @home_team_stats = @game.home_team_stats
    home_stats = @game.home_stats_for_chart
    total_team_stats = @game.home_team.total_team_stats_for_chart(@game)
    @game_data = { home_stats: home_stats, total_team_stats: total_team_stats }
    respond_to do |format|
      format.html
      format.json { render json: @game_data }
    end
  end

  def quarter_data
    score_per_quarter_team = @game.score_per_quarter_team(@game)
    score_per_quarter_opponent = @game.score_per_quarter_opponent(@game)

    @quarter_data = { score_per_quarter_team: score_per_quarter_team, score_per_quarter_opponent: score_per_quarter_opponent }

    render json: @quarter_data
  end

  def total_quarter_data
    total_score_per_quarter_team = @game.total_score_per_quarter_team(@game)
    total_score_per_quarter_opponent = @game.total_score_per_quarter_opponent(@game)

    @total_quarter_data = { total_score_per_quarter_team: total_score_per_quarter_team, total_score_per_quarter_opponent: total_score_per_quarter_opponent }

    render json: @total_quarter_data
  end

  def show
    selected = @game.participations.where(selected?: true)
    user_ids = selected.map(&:user_id)
    my_players = User.where(id: user_ids)
    @my_centers = my_players.group_by(&:position)["C"]
    @my_forwards = my_players.group_by(&:position)["F"]
    @my_guards = my_players.group_by(&:position)["G"]
  end

  def index
    @games = current_user.managed_teams.first.games.where("date < :end", end: Date.today).order(date: :desc)
    @home_team = Team.first
    @away_team = Team.second
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
    @skip_navbar = true
    @skip_footer = true
    @participations_selected = @game.participations.where(selected?: true).distinct
    @titulaires = @participations_selected.where(titulaire?: true)
    @non_titulaires = @participations_selected.where(titulaire?: false)
    @away_team = Team.second
    @home_team = Team.first

  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def participation_params
    params.permit(:authenticity_token, :commit, :id, players: [])
  end
end
