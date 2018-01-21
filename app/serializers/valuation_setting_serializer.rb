class ValuationSettingSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :description,
    :max_value,
    :weight
  )
end
