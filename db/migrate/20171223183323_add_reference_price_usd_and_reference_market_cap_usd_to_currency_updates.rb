class AddReferencePriceUsdAndReferenceMarketCapUsdToCurrencyUpdates < ActiveRecord::Migration[5.1]
  def change
    add_column :currency_updates, :reference_price_usd, :decimal
    add_column :currency_updates, :reference_market_cap_usd, :decimal
  end
end
