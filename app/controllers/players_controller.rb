class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

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
    @players = Player.all
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
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :email, :date_of_birth, :category)
  end
end
