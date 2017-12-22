class CreateCurrencyUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :currency_updates do |t|
      t.integer :rank
      t.decimal :price_usd
      t.decimal :volume_usd_24h
      t.decimal :market_cap_usd
      t.decimal :percentChange1h
      t.decimal :percentChange24h
      t.decimal :percentChange7d
      t.integer :last_updated
      t.references :currency, foreign_key: true

      t.timestamps
    end
  end
end
