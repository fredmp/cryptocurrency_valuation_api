class AddUserToTrackedCurrency < ActiveRecord::Migration[5.1]
  def change
    add_reference :tracked_currencies, :user, foreign_key: true
  end
end
