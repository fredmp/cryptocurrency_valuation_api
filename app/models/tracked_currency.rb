# == Schema Information
#
# Table name: tracked_currencies
#
#  id          :integer          not null, primary key
#  currency_id :integer
#
# Indexes
#
#  index_tracked_currencies_on_currency_id  (currency_id)
#
# Foreign Keys
#
#  fk_rails_...  (currency_id => currencies.id)
#

class TrackedCurrency < ApplicationRecord
  belongs_to :currency
end
