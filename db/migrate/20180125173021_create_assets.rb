class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets do |t|
      t.references :currency, foreign_key: true
      t.decimal :amount, precision: 25, scale: 2
      t.decimal :btcValue, precision: 25, scale: 6
      t.decimal :usdValue, precision: 25, scale: 2
    end
  end
end
