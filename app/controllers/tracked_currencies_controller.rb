class TrackedCurrenciesController < ApplicationController
  def index
    render json: TrackedCurrency.all, with_currency_info: params[:full], status: :ok
  end

  def create
    unless currency
      render json: { message: "#{params['symbol']} does not exist" }, status: :bad_request
      return
    end
    if tracked_currency
      render json: { message: "#{params['symbol']} is already tracked" }, status: :bad_request
      return
    end

    binding.pry
    valuations = ValuationSetting.all.map { |vs| Valuation.new(valuation_setting: vs) }
    tracked = TrackedCurrency.new(currency: currency, valuations: valuations)
    if tracked.save
      render json: tracked, status: :created
    else
      render json: tracked.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  def ids
    render json: TrackedCurrency.joins(:currency).pluck(:"currencies.id"), status: :ok
  end

  private

  def currency
    Currency.find_by(symbol: params['symbol'])
  end

  def tracked_currency
    TrackedCurrency.find_by(currency: currency)
  end
end
