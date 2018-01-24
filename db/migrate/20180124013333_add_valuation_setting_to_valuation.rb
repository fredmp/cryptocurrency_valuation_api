class AddValuationSettingToValuation < ActiveRecord::Migration[5.1]
  def change
    add_reference :valuations, :valuation_setting, foreign_key: true
  end
end
