class AddUserToValuationSetting < ActiveRecord::Migration[5.1]
  def change
    add_reference :valuation_settings, :user, foreign_key: true
  end
end
