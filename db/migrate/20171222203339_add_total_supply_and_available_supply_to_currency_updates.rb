class AddTotalSupplyAndAvailableSupplyToCurrencyUpdates < ActiveRecord::Migration[5.1]
  def change
    add_column :currency_updates, :total_supply, :decimal
    add_column :currency_updates, :available_supply, :decimal
  end
end
