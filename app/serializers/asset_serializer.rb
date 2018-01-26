class AssetSerializer < ActiveModel::Serializer
  attributes :id, :amount, :btc_value, :usd_value
  belongs_to :currency, serializer: CurrencySerializer

  def btc_value
    currency = object.currency
    (object.amount * (currency.price / currency.reference_price)).to_f.round(8)
  end

  def usd_value
    (object.amount * object.currency.price).to_f.round(4)
  end
end
