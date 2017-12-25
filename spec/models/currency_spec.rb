require 'rails_helper'

RSpec.describe Currency, type: :model do

  subject(:currency) { create(:btc) }

  it { is_expected.to have_many(:updates) }

  context 'with currency update attributes' do
    [
      :rank,
      :price,
      :volume_24h,
      :market_cap,
      :total_supply,
      :available_supply,
      :percent_change_1h,
      :percent_change_24h,
      :percent_change_7d,
      :reference_price,
      :reference_max_supply,
      :reference_market_cap
    ].each do |attribute|
      it "responds to #{attribute}" do
        expect(currency.respond_to?(attribute)).to be true
      end
    end
  end

  describe '#last_update' do
    it 'returns most recent currency info' do
      currency.updates << create(:currency_update, percent_change_24h: 9, currency: currency)
      expect(currency.percent_change_24h).to eq(9)
    end
  end

  describe '#max_price' do
    it 'returns max possible price based on reference currency (the one with biggest market cap)' do
      expect(create(:ltc).max_price).to eq(5000)
    end
  end

  describe '#fair_price' do
    it 'returns a suggestion of fair price based on max price, volume and whether it is inflationary or not' do
      expect(create(:eth).fair_price).to eq(5250)
    end
  end

  describe '#inflationary?' do
    it 'assumes a currency is inflationary whether it has max_supply' do
      expect(create(:eth).inflationary?).to be true
      expect(create(:ltc).inflationary?).to be false
    end
  end

  describe '#liquidity' do
    it 'returns a hash with description and penalty based on the volume transactioned in the last 24h' do
      expect(create(:eth).liquidity).to eq({ description: 'Very High', penalty: 0 })
    end
  end

  describe '#growth_potential' do
    it 'returns a percentage based on the difference between current price and fair price' do
      expect(create(:eth).growth_potential).to eq(950)
    end
  end
end
