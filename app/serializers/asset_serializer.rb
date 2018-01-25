class AssetSerializer < ActiveModel::Serializer
  attributes :id, :amount, :btc_value, :usd_value
  belongs_to :currency, serializer: CurrencySerializer
end
