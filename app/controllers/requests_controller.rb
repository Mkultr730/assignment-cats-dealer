class RequestsController < ApplicationController

  def best_deal
    begin
      result = BestDealService.new.get_best_deal(params[:cats_type], params[:user_location])
      render json: { status: 'success', cats: result }, status: :ok
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :unprocessable_entity
    end
  end
end
