class CreateTrackedCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :tracked_currencies do |t|
      t.references :currencies, foreign_key: true
    end
  end
end
