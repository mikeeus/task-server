class ScoresController < ApplicationController

  # GET /scores
  def index
    @leaderboard = User.leaderboard

    render json: @leaderboard
  end

  # POST /scores
  def create
    @score = Score.new(score_params)

    if @score.save
      @score.user.reload
      render json: @score.user, status: :created
    else
      render json: @score.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def score_params
    params.fetch(:score, {}).permit(:user_id, :value)
  end
end
