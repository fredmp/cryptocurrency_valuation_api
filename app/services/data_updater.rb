require 'net/http'
require 'json'
require 'uri'

class DataUpdater

  def initialize(source_url, offset, limit = 5)
    @source_url = source_url
    @offset = offset
    @limit = limit
    @errors = []
  end

  def execute
    begin
      uri = URI("#{@source_url}?start=#{@offset}&limit=#{@limit}")
      response = Net::HTTP.get(uri)
      @result = JSON.parse(response)

      @currencies = Currency.all

      @result.each do |entry|
        currency = find_or_create_currency_from(entry)

        if currency.persisted?
          unless currency.last_updated == entry['last_updated']
            currency_data = currency.updates.create(updated_data_from(entry))
            unless currency_data.persisted?
              add_error(currency.symbol, currency_data.errors, true, false)
            end
          end
        else
          add_error(currency.symbol, currency.errors, false, false)
        end
      end
      output
    rescue => e
      output(e)
    end
  end

  private

  def reference
    @reference ||= ->(currencies) {
      btc = Currency.where(symbol: 'BTC').first
      currencies.detect do |c|
        c['symbol'] == 'BTC'
      end || {
        'price_usd' => btc.price,
        'max_supply' => btc.max_supply,
        'market_cap_usd' => btc.market_cap
      }
    }.call(@result)
  end

  def find_or_create_currency_from(entry)
    @currencies.detect do
      |c| c.external_id == entry['id']
    end || Currency.create(attributes_from(entry))
  end

  def attributes_from(entry)
    attributes = entry.slice(
      'name', 'symbol', 'max_supply', 'last_updated'
    ).symbolize_keys
    attributes[:external_id] = entry['id']
    attributes
  end

  def updated_data_from(entry)
    updated_data = entry.slice(
      'rank', 'percent_change_1h', 'percent_change_24h',
      'percent_change_7d', 'total_supply', 'available_supply'
    ).symbolize_keys
    updated_data[:price] = entry['price_usd']
    updated_data[:volume_24h] = entry['24h_volume_usd']
    updated_data[:market_cap] = entry['market_cap_usd']
    updated_data[:reference_price] = reference['price_usd']
    updated_data[:reference_max_supply] = reference['max_supply']
    updated_data[:reference_market_cap] = reference['market_cap_usd']
    updated_data
  end

  def add_error(symbol, errors, persisted, updated)
    @errors << { currency: symbol, errors: errors, persisted: persisted, updated: updated }
  end

  def output(exception = nil)
    result = { timestamp: DateTime.current.strftime("%F"), offset: @offset, limit: @limit }
    if exception
      result[:status] = :failure
      result[:data] = exception
    elsif @errors.any?
      result[:status] = :partial_failure
      result[:data] = @errors
    else
      result[:status] = :success
    end
    result
  end
end
