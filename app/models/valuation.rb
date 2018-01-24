# == Schema Information
#
# Table name: valuations
#
#  id                   :integer          not null, primary key
#  tracked_currency_id  :integer
#  value                :integer
#  valuation_setting_id :integer
#
# Indexes
#
#  index_valuations_on_tracked_currency_id   (tracked_currency_id)
#  index_valuations_on_valuation_setting_id  (valuation_setting_id)
#
# Foreign Keys
#
#  fk_rails_...  (tracked_currency_id => tracked_currencies.id)
#  fk_rails_...  (valuation_setting_id => valuation_settings.id)
#

class Valuation < ApplicationRecord
  belongs_to :tracked_currency
  belongs_to :valuation_setting
end
