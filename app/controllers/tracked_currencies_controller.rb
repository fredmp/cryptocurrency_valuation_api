class TrackedCurrenciesController < ApplicationController
  def index
    render json: TrackedCurrency.where(user: current_user), with_currency_info: params[:full], status: :ok
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

    valuations = ValuationSetting.all.map { |vs| Valuation.new(valuation_setting: vs, value: 0) }
    tracked = TrackedCurrency.new(currency: currency, user: current_user, valuations: valuations)
    if tracked.save
      render json: tracked, status: :created
    else
      render json: tracked.errors, status: :unprocessable_entity
    end
  end

  def update
    unless currency
      render json: { message: "#{params['symbol']} does not exist" }, status: :bad_request
      return
    end
    unless tracked_currency
      render json: { message: "#{params['symbol']} is not tracked" }, status: :bad_request
      return
    end

    if tracked_currency.update_attribute(:notes, params[:notes])
      render json: tracked_currency, status: :ok
    else
      render json: tracked_currency.errors, status: :unprocessable_entity
    end
  end

  def destroy
    unless currency
      render json: { message: "#{params['symbol']} does not exist" }, status: :bad_request
      return
    end
    unless tracked_currency
      render json: { message: "#{params['symbol']} is not tracked" }, status: :bad_request
      return
    end

    tracked_currency.destroy
    head :no_content
  end

  def ids
    render json: TrackedCurrency.where(user: current_user).joins(:currency).pluck(:"currencies.id"), status: :ok
  end

  private

  def currency
    @currency ||= Currency.find_by(symbol: params['symbol'])
  end

  def tracked_currency
    @tracked_currency ||= TrackedCurrency.find_by(currency: currency, user: current_user)
  end
end
