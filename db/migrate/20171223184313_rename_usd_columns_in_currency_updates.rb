class RenameUsdColumnsInCurrencyUpdates < ActiveRecord::Migration[5.1]
  def change
    rename_column :currency_updates, :price_usd, :price
    rename_column :currency_updates, :volume_usd_24h, :volume_24h
    rename_column :currency_updates, :market_cap_usd, :market_cap
    rename_column :currency_updates, :reference_price_usd, :reference_price
    rename_column :currency_updates, :reference_market_cap_usd, :reference_market_cap
  end
end
