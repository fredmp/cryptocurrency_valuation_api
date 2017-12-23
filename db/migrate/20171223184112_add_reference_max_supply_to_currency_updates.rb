class AddReferenceMaxSupplyToCurrencyUpdates < ActiveRecord::Migration[5.1]
  def change
    add_column :currency_updates, :reference_max_supply, :decimal
  end
end
