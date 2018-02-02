class ChangePriceAndAmountPrecision < ActiveRecord::Migration[5.1]
  def change
    change_column :assets, :amount, :decimal, precision: 25, scale: 8
    change_column :assets, :btc_value, :decimal, precision: 25, scale: 8
    change_column :assets, :usd_value, :decimal, precision: 25, scale: 8

    change_column :currency_updates, :price, :decimal, precision: 25, scale: 8
    change_column :currency_updates, :reference_price, :decimal, precision: 25, scale: 8
  end
end
