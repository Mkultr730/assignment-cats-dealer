class CatsController < ApplicationController

  def best_deal
    result = BestCatDealService.new(cat_params).execute
    render json: { status: 'success', **result }, status: :ok
  end

  private

  def cat_params 
    params.permit(:cats_type, :user_location)
  end
end
