class ChangeColumnNamesAndDefaultsInAssets < ActiveRecord::Migration[5.1]
  def change
    rename_column(:assets, :btcValue, :btc_value)
    rename_column(:assets, :usdValue, :usd_value)
    change_column(:assets, :btc_value, :decimal, precision: 25, scale: 6, default: 0)
    change_column(:assets, :usd_value, :decimal, precision: 25, scale: 2, default: 0)
    change_column(:assets, :amount, :decimal, precision: 25, scale: 2, default: 0)
  end
end
