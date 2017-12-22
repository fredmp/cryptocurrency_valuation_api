class RenamePercentChangeColumnsInCurrencyUpdates < ActiveRecord::Migration[5.1]
  def change
    rename_column :currency_updates, :percentChange1h, :percent_change_1h
    rename_column :currency_updates, :percentChange24h, :percent_change_24h
    rename_column :currency_updates, :percentChange7d, :percent_change_7d
  end
end
