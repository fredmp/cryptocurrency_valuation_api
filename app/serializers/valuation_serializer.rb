class ValuationSerializer < ActiveModel::Serializer
  attributes :id, :value
  belongs_to :valuation_setting, serializer: ValuationSettingSerializer
end
