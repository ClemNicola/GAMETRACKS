# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  # Skip user authentication for the homepage
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end
end
