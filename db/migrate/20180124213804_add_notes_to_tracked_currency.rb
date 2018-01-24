class AddNotesToTrackedCurrency < ActiveRecord::Migration[5.1]
  def change
    add_column :tracked_currencies, :notes, :string
  end
end
