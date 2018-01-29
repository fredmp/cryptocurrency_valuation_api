class ValuationsController < ApplicationController
  def update
    valuation = Valuation.find(params[:id])
    unless valuation
      head :not_found
      return
    end
    if valuation.tracked_currency.user != current_user
      head :unauthorized
      return
    end

    valuation.value = params[:value]
    if valuation.save
      render json: valuation, status: :ok
    else
      render json: valuation.errors, status: :unprocessable_entity
    end
  end
end
