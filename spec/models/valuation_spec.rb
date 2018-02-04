require 'rails_helper'

RSpec.describe Valuation, type: :model do

  subject(:valuation) {
    Valuation.create(valuation_setting: create(:innovation), tracked_currency: create(:tracked_currency))
  }

  it { is_expected.to belong_to(:tracked_currency) }
  it { is_expected.to belong_to(:valuation_setting) }
  it { is_expected.to respond_to(:value) }

  describe '#quota' do
    it 'returns the price considering all valuations' do
      expect(valuation.quota.to_f).to eq(10500)
    end
  end

  describe '#max_value' do
    it 'returns the price considering all valuations' do
      expect(valuation.max_value).to eq(10)
    end
  end

  describe '#penalty' do
    it 'returns the price considering all valuations' do
      expect(valuation.penalty).to eq(1)
    end
  end

end
