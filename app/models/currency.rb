class Currency < ApplicationRecord
  has_many :updates, class_name: 'CurrencyUpdate', foreign_key: 'currency_id'
end
