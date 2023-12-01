# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  # Skip user authentication for the homepage
<<<<<<< HEAD
  skip_before_action :authenticate_user!, only: %i[home dashboard]
=======
  skip_before_action :authenticate_user!, only: %i[home]
>>>>>>> 47f3d3d54f14f0de02be241ea98a2922e7ab8e48

  def home
    @skip_navbar = true
    @skip_footer = true
  end

  def dashboard
<<<<<<< HEAD
    @user = current_user
=======
    @coach_team = current_user.managed_teams.first
    @next_game = @coach_team.games.distinct.select{ |game| game.date >= Date.today }.min_by(&:date)

    if @next_game.nil?
      @home_team = nil
      @away_team = nil
    else
      @home_team = @next_game.home_team
      @away_team = @next_game.away_team
    end
  end

  def calendar
>>>>>>> 47f3d3d54f14f0de02be241ea98a2922e7ab8e48
  end
end
