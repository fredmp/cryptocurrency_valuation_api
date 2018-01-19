require 'net/http'
require 'json'
require 'uri'

namespace :currency do
  desc 'This task fetches all currencies'
  task :fetch_all => :environment do
    url = 'https://api.coinmarketcap.com/v1/ticker/?limit=150'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)

    currencies = Currency.all

    reference = result.max { |a, b| a['market_cap_usd'].to_f <=> b['market_cap_usd'].to_f }

    result.each do |entry|
      currency = find_or_create_currency(currencies, entry)

      if currency.persisted?
        unless currency.last_updated == entry['last_updated']
          currency_data = currency.updates.create(updated_data_from(entry, reference))
          unless currency_data.persisted?
            # Log invalid currency data
            puts "#{currency_data.errors}"
          end
        end
      else
        # Log currency not saved
        puts 'Currency not saved'
      end
    end
  end

  def find_or_create_currency(currencies, entry)
    currencies.detect { |c| c.external_id == entry['id'] } || Currency.create(attributes_from(entry))
  end

  def attributes_from(entry)
    attributes = entry.slice('name', 'symbol', 'max_supply', 'last_updated').symbolize_keys
    attributes[:external_id] = entry['id']
    attributes
  end

  def updated_data_from(entry, reference)
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
end
