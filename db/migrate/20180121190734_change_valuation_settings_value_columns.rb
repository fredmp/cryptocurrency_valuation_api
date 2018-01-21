class ChangeValuationSettingsValueColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :valuation_settings, :to, :max_value
    remove_column :valuation_settings, :from, :integer
  end
end
