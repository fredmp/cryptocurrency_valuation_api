require 'rails_helper'

RSpec.describe CurrencyUpdate, type: :model do

  it { is_expected.to belong_to(:currency) }
  it { is_expected.to respond_to(:rank) }
  it { is_expected.to respond_to(:price) }
  it { is_expected.to respond_to(:volume_24h) }
  it { is_expected.to respond_to(:market_cap) }
  it { is_expected.to respond_to(:percent_change_1h) }
  it { is_expected.to respond_to(:percent_change_24h) }
  it { is_expected.to respond_to(:percent_change_7d) }
  it { is_expected.to respond_to(:total_supply) }
  it { is_expected.to respond_to(:available_supply) }
  it { is_expected.to respond_to(:reference_price) }
  it { is_expected.to respond_to(:reference_market_cap) }
  it { is_expected.to respond_to(:reference_max_supply) }

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
