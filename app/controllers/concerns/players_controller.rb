class PlayersController < ApplicationController
  def select_for_game
    # Fetch coach's team and upcoming game information
    @coach = current_user.coach
    @team = @coach.team
    @upcoming_game = @team.upcoming_games.first

    # Select players for the game
    @selected_players = @team.players.where(id: params[:player_ids])
  end
end
