FactoryBot.define do
  factory :valuation do

    tracked_currency
    association :valuation_setting, factory: :innovation

    factory :innovation_valuation do
      value 8
    end

    factory :wallet_valuation do
      value 2
    end
  end
end
