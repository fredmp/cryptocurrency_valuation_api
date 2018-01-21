class ValuationSettingSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :description,
    :max_value,
    :weight
  )
end
