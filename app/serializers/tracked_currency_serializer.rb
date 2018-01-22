class TrackedCurrencySerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :currency, serializer: CurrencySerializer
end
