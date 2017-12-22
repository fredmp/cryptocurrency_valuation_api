class AddLastUpdatedToCurrencies < ActiveRecord::Migration[5.1]
  def change
    add_column :currencies, :last_updated, :integer
  end
end
