class AddNameToValuationSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :valuation_settings, :name, :string
  end
end
