require 'rails_helper'

RSpec.describe CurrencyUpdate, type: :model do
  it { is_expected.to belong_to(:currency) }

  describe '.old_entries' do
    it 'returns entries older than 15 minutes' do
      ltc = create(:ltc)

      CurrencyUpdate.create(currency: ltc, price: 840)
      CurrencyUpdate.create(currency: ltc, price: 940)
      update = CurrencyUpdate.create(currency: ltc, price: 440)

      update.update_attribute(:created_at, DateTime.current - 15.minutes)

      expect(CurrencyUpdate.old_entries.size).to eq(1)
    end
  end
end
