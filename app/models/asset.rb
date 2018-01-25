# == Schema Information
#
# Table name: assets
#
#  id          :integer          not null, primary key
#  currency_id :integer
#  amount      :decimal(25, 2)   default(0.0)
#  btc_value   :decimal(25, 6)   default(0.0)
#  usd_value   :decimal(25, 2)   default(0.0)
#
# Indexes
#
#  index_assets_on_currency_id  (currency_id)
#
# Foreign Keys
#
#  fk_rails_...  (currency_id => currencies.id)
#

class Asset < ApplicationRecord
  belongs_to :currency
end
