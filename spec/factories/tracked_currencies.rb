FactoryBot.define do
  factory :tracked_currency do
    user
    association :currency, factory: :eth
  end
end
