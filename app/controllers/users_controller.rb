class UsersController < ApplicationController
  before_action :set_user, only: :show

  def show
    render json: { user: ActiveModelSerializers::SerializableResource.new(@user), scores: @user.scores }
  end

  def index
    render json: User
      .all
      .left_joins(:scores)
      .order('sum(scores.value) DESC')
      .group('users.id')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
