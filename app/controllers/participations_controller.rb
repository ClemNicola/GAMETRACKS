class ParticipationsController < ApplicationController
  def new
    @participation = Participation.new
    @user = current_user
    @team = Team.where(coach: @user)
    @players_list = @team.first.players.group_by(&:position)
    @game = Game.find(params[:game_id])
  end

  def titularize
    @participations = Participation.where(user_id: params[:players], game_id: params[:id], selected?: true)
    @participations.update_all(titulaire?: true)
    redirect_to play_game_path(params[:id])
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
