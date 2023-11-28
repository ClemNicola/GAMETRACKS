# app/controllers/coaches_controller.rb
class CoachesController < ApplicationController
  # Display the coach's profile and dashboard
  def show
    @coach = current_user.coach
    @team = @coach.team
    @upcoming_games = @team.upcoming_games
  end
end

