class ReverseController < ApplicationController

  def reverse
    original = reverse_params[:message] || ''
    reversed = original.reverse
    render json: { original: { data: original }, message: reversed }
  end

  private

  def reverse_params
    params.permit(:message)
  end
end
