class ParticipationsController < ApplicationController
  # before_action :player_name

  def new
    @participation = Participation.new
    @user = current_user
    @team = Team.where(coach: @user)
    @players_list = @team.first.players.group_by(&:position)
    @game = Game.find(params[:game_id])
  end

  def titularize
    # set_game
    # user = User.find(params[:user_id])
    # participations = @game.participations
    # to_titularize = participations.where(user: user)
    # player_to_titularize = to_titularize.first
    # if player_to_titularize.titulaire?
    #   player_to_titularize.titulaire = false
    # else
    #   player_to_titularize.titulaire = true
    # end
    # player_to_titularize.save!
    # render controller: "games", action: "show"
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
