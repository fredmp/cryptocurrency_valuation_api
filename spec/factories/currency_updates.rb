FactoryBot.define do
  factory :currency_update do
    factory :update_btc do
      rank 1
      price 20_000
      volume_24h 10_574_600_000
      market_cap 200_000_000_000
      percent_change_1h 20.2
      percent_change_24h 14.2
      percent_change_7d 8.8
      total_supply 14_000_000
      available_supply 14_000_000
      reference_price 20_000
      reference_max_supply 21_000_000
      reference_market_cap 200_000_000_000
    end

    factory :update_ltc do
      rank 5
      price 280
      volume_24h 99_000_000
      market_cap 20_000_000
      percent_change_1h 8.2
      percent_change_24h 2.2
      percent_change_7d 48
      total_supply 74_000_000
      available_supply 74_000_000
      reference_price 20_000
      reference_max_supply 21_000_000
      reference_market_cap 200_000_000_000
    end

    factory :update_eth do
      rank 2
      price 500
      volume_24h 2_459_250_000
      market_cap 99_000_000
      percent_change_1h 9.2
      percent_change_24h 22
      percent_change_7d 20
      total_supply 40_000_000
      available_supply 40_000_000
      reference_price 20_000
      reference_max_supply 21_000_000
      reference_market_cap 200_000_000_000
    end
  end
end
