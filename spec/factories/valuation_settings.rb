FactoryBot.define do
  factory :valuation_setting do
    user
    factory :innovation do
      name 'Innovation'
      max_value 10
      weight 40
    end

    factory :wallet do
      name 'Wallet'
      max_value 5
      weight 10
    end
  end
end
