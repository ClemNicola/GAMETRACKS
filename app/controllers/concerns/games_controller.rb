class GamesController < ApplicationController
  def prepare_game
    # Fetch coach's team and upcoming game information
    @coach = current_user.coach
    @team = @coach.team
    @upcoming_game = @team.upcoming_games.first
  end

  def select_players
    # Process player selection and update game preparation status
    @coach = current_user.coach
    @team = @coach.team
    @game = Game.find(params[:game_id])

    # Update game preparation status
    @game.update(preparation_status: 'players_selected')

    # Redirect to next step of game preparation
    redirect_to game_preparation_next_step_path(@game)
  end

  def team_composition
    # Fetch game and selected players
    @game = Game.find(params[:game_id])
    @selected_players = @game.selected_players
  end

  def in_progress
    # Display the "GAME TIME" message and redirect after 2 seconds
    @game = Game.find(params[:game_id])
    @game.update(status: 'in_progress')

    render :in_progress
  end

  def play
    # Fetch game and relevant information for game play
    @game = Game.find(params[:game_id])
    @team = @game.team
    @coach = current_user.coach

    # Display game play interface
    render :play
  end
end
