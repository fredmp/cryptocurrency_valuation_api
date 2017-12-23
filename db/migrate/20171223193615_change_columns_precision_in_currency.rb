class ChangeColumnsPrecisionInCurrency < ActiveRecord::Migration[5.1]
  def change
    change_column :currencies, :max_supply, :decimal, precision: 15, scale: 2
  end
end
