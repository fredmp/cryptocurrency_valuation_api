# == Schema Information
#
# Table name: valuation_settings
#
#  id          :integer          not null, primary key
#  description :string
#  max_value   :integer
#  weight      :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string
#

class ValuationSetting < ApplicationRecord
  validates :name, :max_value, :weight, presence: true
  validates :max_value, inclusion: { in: 1..10 }
  validates :weight, numericality: true
end
