# == Schema Information
#
# Table name: currencies
#
#  id           :integer          not null, primary key
#  external_id  :string
#  name         :string
#  symbol       :string
#  max_supply   :decimal(15, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  last_updated :integer
#

class Currency < ApplicationRecord
  has_many :updates, class_name: 'CurrencyUpdate', foreign_key: 'currency_id', dependent: :destroy

  [
    :rank,
    :price,
    :volume_24h,
    :market_cap,
    :total_supply,
    :available_supply,
    :percent_change_1h,
    :percent_change_24h,
    :percent_change_7d,
    :reference_price,
    :reference_max_supply,
    :reference_market_cap
  ].each do |name|
    define_method name.to_s do
      last_update.send(name)
    end
  end

  def growth_potential
    ((fair_price - price) / price * 100).to_f.round(2)
  end

  def fair_price
    @fair_price ||= max_price * (inflationary? ? 0.50 : 1) * ((10 - liquidity[:penalty]) / 10.0)
  end

  def max_price
    @max_price ||= if (max_supply.nil? && total_supply.nil? && available_supply.nil?) ||
                      reference_price.nil? || reference_max_supply.nil? ||
                      reference_price == price && reference_max_supply == (max_supply || total_supply)
      price
    else
      reference_price / ((max_supply || total_supply || available_supply) / reference_max_supply)
    end.to_f.round(2)
  end

  def inflationary?
    max_supply.nil?
  end

  def liquidity
    @liquidity ||= case volume_24h
    when volume_24h.nil? || volume_24h < 0
      return { description: 'None', penalty: 5 }
    when 0..1_000_000
      return { description: 'Very Low', penalty: 4 }
    when 1_000_001..10_000_000
      return { description: 'Low', penalty: 3 }
    when 10_000_001..100_000_000
      return { description: 'Medium', penalty: 2 }
    when 100_000_001..500_000_000
      return { description: 'High', penalty: 1 }
    else
      return { description: 'Very High', penalty: 0 }
    end
  end

  def last_update
    @last_update ||= updates.last
  end
end
