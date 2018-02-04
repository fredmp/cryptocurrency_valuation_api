require 'rails_helper'

RSpec.describe TrackedCurrency, type: :model do

  subject(:tracked) { TrackedCurrency.new }

  it { is_expected.to belong_to(:currency) }
  it { is_expected.to have_many(:valuations) }
  it { is_expected.to respond_to(:notes) }

  before(:each) do
    innovation = FactoryBot.create(:innovation)
    wallet = FactoryBot.create(:wallet)
    eth = create(:eth)
    tracked.currency = eth
    tracked.valuations = [
      build(:innovation_valuation, tracked_currency: tracked, valuation_setting: innovation),
      build(:wallet_valuation, tracked_currency: tracked, valuation_setting: wallet)
    ]
  end

  describe '#expected_price' do
    it 'returns the price considering all valuations' do
      expect(tracked.expected_price).to eq(7560)
    end
  end

  describe '#expected_growth' do
    it 'returns the expected growth considering all valuations' do
      expect(tracked.expected_growth).to eq(1412)
    end
  end

  describe '#total_quota' do
    it 'returns currency max price divided by total weight' do
      expect(tracked.total_quota.to_f).to eq(210)
    end
  end

end
