class ParticipationsController < ApplicationController
  # before_action :player_name

  def new
    @participation = Participation.new
    @user = current_user
    @team = Team.where(coach: @user)
    @players_list = @team.first.players.group_by(&:position)
    @game = Game.find(params[:game_id])
  end
  
end
