# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  # Skip user authentication for the homepage
  skip_before_action :authenticate_user!, only: %i[home]

  def home
    @skip_navbar = true
    @skip_footer = true
  end

  def dashboard
    @coach_team = current_user.managed_teams.first
    @next_game = Game.first
    # @next_game = @coach_team.games.distinct.select { |game| game.date >= Date.today }.min_by(&:date)

    @home_team = @next_game.home_team
    @away_team = @next_game.away_team
  end

  def calendar
  end

  def fake_new
    @skip_navbar = true
    @skip_footer = true
    
  end
end
