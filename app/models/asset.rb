# == Schema Information
#
# Table name: assets
#
#  id          :integer          not null, primary key
#  currency_id :integer
#  amount      :decimal(25, 8)   default(0.0)
#  btc_value   :decimal(25, 8)   default(0.0)
#  usd_value   :decimal(25, 8)   default(0.0)
#  user_id     :integer
#
# Indexes
#
#  index_assets_on_currency_id  (currency_id)
#  index_assets_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (currency_id => currencies.id)
#  fk_rails_...  (user_id => users.id)
#

class Asset < ApplicationRecord
  belongs_to :currency
  belongs_to :user
end
