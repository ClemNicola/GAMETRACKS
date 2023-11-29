# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  # Skip user authentication for the homepage
  skip_before_action :authenticate_user!, only: %i[home dashboard]

  def home
  end

  def dashboard
    @user = current_user
  end

end
