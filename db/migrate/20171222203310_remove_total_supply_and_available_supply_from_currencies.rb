class RemoveTotalSupplyAndAvailableSupplyFromCurrencies < ActiveRecord::Migration[5.1]
  def change
    remove_column :currencies, :total_supply, :decimal
    remove_column :currencies, :available_supply, :decimal
  end
end
