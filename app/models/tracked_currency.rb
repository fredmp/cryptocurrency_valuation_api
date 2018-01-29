# == Schema Information
#
# Table name: tracked_currencies
#
#  id          :integer          not null, primary key
#  currency_id :integer
#  notes       :string
#  user_id     :integer
#
# Indexes
#
#  index_tracked_currencies_on_currency_id  (currency_id)
#  index_tracked_currencies_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (currency_id => currencies.id)
#  fk_rails_...  (user_id => users.id)
#

class TrackedCurrency < ApplicationRecord
  belongs_to :currency
  belongs_to :user
  has_many :valuations, dependent: :destroy

  def expected_price
    return currency.price if zero_weight_in_settings || zero_weight_in_valuations

    evaluated_max_price = currency.max_price * (total_weight / 100)
    not_affected_max_price = currency.max_price * (remaining_weight / 100)

    expected = valuations.inject(evaluated_max_price) do |accumulator, valuation|
      accumulator -= valuation.quota * valuation.penalty
    end
    [0, expected + not_affected_max_price].max.to_f.round(4)
  end

  def expected_growth
    return 0 if expected_price == currency.price
    ((expected_price - currency.price) / currency.price * 100).to_f.round(2)
  end

  def total_quota
    currency.max_price / total_weight
  end

  private

  def zero_weight_in_settings
    total_weight == 0
  end

  def zero_weight_in_valuations
    valuations.sum(&:value) == 0
  end

  def remaining_weight
    100 - total_weight
  end

  def total_weight
    @total_weight ||= ValuationSetting.all.sum(&:weight)
  end
end
