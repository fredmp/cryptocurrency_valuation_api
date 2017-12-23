class CurrenciesController < ApplicationController
  def index
    render json: Currency.all, status: 200
  end
end
