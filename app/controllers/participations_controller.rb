class ParticipationsController < ApplicationController
  def new
    @user = current_user
    @team = Team.where(coach: @user)
    @players_list = @team.first.players.all
  end

  def create
  end
end
