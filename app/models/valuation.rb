# == Schema Information
#
# Table name: valuations
#
#  id                  :integer          not null, primary key
#  tracked_currency_id :integer
#  value               :integer
#
# Indexes
#
#  index_valuations_on_tracked_currency_id  (tracked_currency_id)
#
# Foreign Keys
#
#  fk_rails_...  (tracked_currency_id => tracked_currencies.id)
#

class Valuation < ApplicationRecord
  belongs_to :tracked_currency
end
