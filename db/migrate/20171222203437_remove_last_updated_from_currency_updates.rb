class RemoveLastUpdatedFromCurrencyUpdates < ActiveRecord::Migration[5.1]
  def change
    remove_column :currency_updates, :last_updated, :integer
  end
end
