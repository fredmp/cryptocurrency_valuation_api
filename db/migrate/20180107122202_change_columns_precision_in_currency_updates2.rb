class ChangeColumnsPrecisionInCurrencyUpdates2 < ActiveRecord::Migration[5.1]
  def change
    change_column :currency_updates, :price, :decimal, precision: 25, scale: 2
    change_column :currency_updates, :volume_24h, :decimal, precision: 25, scale: 2
    change_column :currency_updates, :market_cap, :decimal, precision: 25, scale: 2
    change_column :currency_updates, :total_supply, :decimal, precision: 25, scale: 2
    change_column :currency_updates, :available_supply, :decimal, precision: 25, scale: 2
    change_column :currency_updates, :reference_price, :decimal, precision: 25, scale: 2
    change_column :currency_updates, :reference_market_cap, :decimal, precision: 25, scale: 2
    change_column :currency_updates, :reference_max_supply, :decimal, precision: 25, scale: 2
  end
end
