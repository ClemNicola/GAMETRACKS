class ParticipationsController < ApplicationController
  def new
    @participation = Participation.new
    @user = current_user
    @team = Team.where(coach: @user)
    @players_list = @team.first.players.group_by(&:position)
    @game = Game.find(params[:game_id])
  end

  def titularize
    params[:players].each do |player_id|
      @participation = Participation.where(user_id: player_id, game_id: params[:id], selected?: true)
      @participation.update(titulaire?: true)
    end
    redirect_to play_game_path(params[:id])
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
