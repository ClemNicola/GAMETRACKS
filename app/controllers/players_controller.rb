class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy, :player_data, :radar_player_data]

  def player_data
    player_stat_for_game = @player.player_stat_for_game(@player.games.last)
    avg_player_stats = @player.avg_player_stats(@player)

    @player_data = { player_stat_for_game: player_stat_for_game, avg_player_stats: avg_player_stats}
    render json: @player_data
  end

  def radar_player_data
    radar_total_stats = @player.radar_total_stats(@player)

    @radar_total_stats = { radar_total_stats: radar_total_stats }
    render json: @radar_total_stats
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to players_path, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def index
    @user = current_user
    @team = Team.find_by(coach: @user)
    if @team
      @players = @team.players
    else
      @players = []
    end
  end

  def show
  end

  def edit
  end

  def update
    if @player.update(player_params)
      redirect_to players_path, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @player.destroy
    redirect_to players_path, notice: 'Player was successfully deleted.'
  end

  private

  def set_player
    @player = User.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :email, :date_of_birth, :category)
  end
end
