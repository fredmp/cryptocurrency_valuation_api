FactoryBot.define do
  factory :currency do
    factory :btc do
      external_id 'bitcoin'
      name 'Bitcoin'
      symbol 'BTC'
      max_supply 21_000_000

      after(:create) do |currency, evaluator|
        FactoryBot.create_list(:update_btc, 1, currency: currency)
      end
    end

    factory :ltc do
      external_id 'litecoin'
      name 'Litecoin'
      symbol 'LTC'
      max_supply 84_000_000

      after(:create) do |currency, evaluator|
        FactoryBot.create_list(:update_ltc, 1, currency: currency)
      end
    end

    factory :eth do
      external_id 'ethereum'
      name 'Ethereum'
      symbol 'ETH'

      after(:create) do |currency, evaluator|
        FactoryBot.create_list(:update_eth, 1, currency: currency)
      end
    end
  end
end
