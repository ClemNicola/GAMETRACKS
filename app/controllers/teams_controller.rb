class TeamsController < ApplicationController

  def new
  end

  def create
  end

  private

  def teams_params
    params.require(:team).permit(:photo)
  end
end
