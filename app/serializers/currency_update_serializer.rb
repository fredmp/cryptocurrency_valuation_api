class CurrencyUpdateSerializer < ActiveModel::Serializer
  attributes(
    :rank,
    :price,
    :volume_24h,
    :market_cap,
    :percent_change_1h,
    :percent_change_24h,
    :percent_change_7d,
    :total_supply,
    :available_supply
  )
end
