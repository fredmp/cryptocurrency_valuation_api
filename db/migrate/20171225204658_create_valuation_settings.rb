class CreateValuationSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :valuation_settings do |t|
      t.string :description
      t.integer :from
      t.integer :to
      t.decimal :weight, precision: 8, scale: 2

      t.timestamps
    end
  end
end
