class RenameForeignKeyInValuations < ActiveRecord::Migration[5.1]
  def change
    rename_column :valuations, :tracked_currencies_id, :tracked_currency_id
  end
end
