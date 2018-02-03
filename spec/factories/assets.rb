FactoryBot.define do
  factory :asset do
    user
    association :currency, factory: :eth
  end
end
