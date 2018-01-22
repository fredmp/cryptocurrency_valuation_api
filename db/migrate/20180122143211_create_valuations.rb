class CreateValuations < ActiveRecord::Migration[5.1]
  def change
    create_table :valuations do |t|
      t.references :tracked_currencies, foreign_key: true
      t.integer :value
    end
  end
end
