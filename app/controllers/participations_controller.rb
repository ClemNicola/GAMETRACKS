class ParticipationsController < ApplicationController
  def new
    @participation = Participation.new
    @user = current_user
    @team = Team.where(coach: @user)
<<<<<<< HEAD
    @players_list = @team.first.players.all
  end

  def create
  end
=======
    @players_list = @team.first.players.group_by(&:position)
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

>>>>>>> 47f3d3d54f14f0de02be241ea98a2922e7ab8e48
end
