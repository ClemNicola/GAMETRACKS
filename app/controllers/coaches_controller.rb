class CoachesController < ApplicationController
  before_action :set_coach, only: [:edit, :update, :destroy]

  def new
    @coach = Coach.new
  end

  def create
    @coach = Coach.new(coach_params)
    if @coach.save
      redirect_to root_path, notice: 'Coach was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @coach.update(coach_params)
      redirect_to root_path, notice: 'Coach was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @coach.destroy
    redirect_to root_path, notice: 'Coach was successfully deleted.'
  end

  private

  def set_coach
    @coach = Coach.find(params[:id])
  end

  def coach_params
    params.require(:coach).permit(:name, :email, :date_of_birth, :category)
  end
end
