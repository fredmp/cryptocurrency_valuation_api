class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string :external_id
      t.string :name
      t.string :symbol
      t.decimal :max_supply
      t.decimal :total_supply
      t.decimal :available_supply

      t.timestamps
    end
  end
end
