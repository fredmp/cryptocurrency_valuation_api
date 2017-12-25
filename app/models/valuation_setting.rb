# == Schema Information
#
# Table name: valuation_settings
#
#  id          :integer          not null, primary key
#  description :string
#  from        :integer
#  to          :integer
#  weight      :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ValuationSetting < ApplicationRecord
  validates :description, :from, :to, :weight, presence: true
  validates :from, :to, inclusion: { in: 1..10 }
  validates :weight, numericality: true
end
