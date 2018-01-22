class RenameForeignKeyInTrackedCurrencies < ActiveRecord::Migration[5.1]
  def change
    rename_column :tracked_currencies, :currencies_id, :currency_id
  end
end
