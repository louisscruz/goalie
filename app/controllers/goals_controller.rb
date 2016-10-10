class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description)
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end
end
