# == Schema Information
#
# Table name: tracked_currencies
#
#  id          :integer          not null, primary key
#  currency_id :integer
#
# Indexes
#
#  index_tracked_currencies_on_currency_id  (currency_id)
#
# Foreign Keys
#
#  fk_rails_...  (currency_id => currencies.id)
#

class TrackedCurrency < ApplicationRecord
  belongs_to :currency
  has_many :valuations

  def expected_price
    total_weight = ValuationSetting.all.sum(&:weight)
    return currency.price if total_weight == 0 || valuations.sum(&:value) == 0
    total_quota = currency.max_price / total_weight
    expected = valuations.inject(currency.max_price) do |accumulator, valuation|
      valuation_quota = valuation.valuation_setting.weight * total_quota
      valuation_percentage = (1.0 - (valuation.value.to_f / valuation.valuation_setting.max_value.to_f)).round(2)
      accumulator -= valuation_quota * valuation_percentage
    end
    [0, expected].max.to_f.round(4)
  end

  def expected_growth
    return 0 if expected_price == currency.price
    ((expected_price - currency.price) / currency.price * 100).to_f.round(2)
  end
end
