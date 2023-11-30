class ParticipationsController < ApplicationController
  def new
    @participation = Participation.new
    @user = current_user
    @team = Team.where(coach: @user)
    @players_list = @team.first.players.all
    @game = Game.find(params[:game_id])
  end

  def create
    @participation = Participation.new(participation_params)
    if @participation.save
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  private

  def participation_params
    params.require(:participation).permit(:team_id, :game_id, :player_id)
  end

end
