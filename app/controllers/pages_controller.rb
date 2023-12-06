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
    @next_game = @coach_team.games.where("date >= :end", end: Date.today).first
    @wins = @coach_team.team_stat.total_wins
    @losses = @coach_team.team_stat.total_losses
    @win_rate = (@wins.fdiv(@wins + @losses) * 100).round(1)
    @avg_pts = @coach_team.total_team_stats(@coach_team)[:point].fdiv(@wins + @losses).round(0)
    @home_team = Team.first
    @away_team = Team.second
  end

  def calendar
    @games = current_user.managed_teams.first.games.where("date >= :end", end: Date.today).order(date: :asc)
    @home_team = Team.first
    @away_team = Team.second
  end

  def fake_new
    @skip_navbar = true
    @skip_footer = true
  end

  def profile
    @user = current_user
  end

  def update_profile
    @user = current_user

    if @user.update(profile_params)
      redirect_to dashboard_path, notice: 'Profile updated successfully.'
    else
      render :profile
    end
  end

  private

  def profile_params
    params.permit(:category, :club_name, :age_level, :coach_category, :city, :license_id, :phone, :sex, :description, :position, :height)
  end
end
