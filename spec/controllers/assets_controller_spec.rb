require 'rails_helper'

RSpec.describe AssetsController, type: :controller do

  let(:asset) { create(:asset) }

  before(:each) do
    allow(controller).to receive(:current_user) { asset.user }
  end

  describe 'PATCH #update' do
    it 'updates a existent asset' do
      post :update, params: { symbol: 'ETH', amount: 20 }
      expect(response).to have_http_status(:success)
      expect(response.body).to eq({
        'id': asset.id,
        'amount': '20.0',
        'btcValue': 0.5,
        'usdValue': 10000.0,
        'currency': {
          'id': asset.currency.id,
          'rank': 2,
          'symbol': 'ETH',
          'name': 'Ethereum',
          'price': '500.0',
          'volume24h': '2459250000.0',
          'marketCap': '99000000.0',
          'percentChange1h': '9.2',
          'percentChange24h': '22.0',
          'percentChange7d': '20.0',
          'totalSupply': '40000000.0',
          'availableSupply': '40000000.0',
          'maxSupply': nil,
          'maxPrice': 10500.0,
          'liquidity': 'Very High',
          'inflationary': true,
          'growthPotential': 2000.0
        }
      }.to_json)
    end
  end

  describe 'POST #create' do
    it 'creates a new asset' do
      ltc = create(:ltc)
      post :create, params: { symbol: 'LTC' }
      last_id = Asset.last.id
      expect(response).to have_http_status(:success)
      expect(response.body).to eq({
        'id': last_id,
        'amount': '0.0',
        'btcValue': 0.0,
        'usdValue': 0.0,
        'currency': {
          'id': ltc.id,
          'rank': 5,
          'symbol': 'LTC',
          'name': 'Litecoin',
          'price': '280.0',
          'volume24h': '99000000.0',
          'marketCap': '20000000.0',
          'percentChange1h': '8.2',
          'percentChange24h': '2.2',
          'percentChange7d': '48.0',
          'totalSupply': '74000000.0',
          'availableSupply': '74000000.0',
          'maxSupply': '84000000.0',
          'maxPrice': 5000.0,
          'liquidity': 'Medium',
          'inflationary': false,
          'growthPotential': 1685.71
        }
      }.to_json)
    end
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to eq([
        {
          'id': asset.id,
          'amount': '0.0',
          'btcValue': 0.0,
          'usdValue': 0.0,
          'currency': {
            'id': asset.currency.id,
            'rank': 2,
            'symbol': 'ETH',
            'name': 'Ethereum',
            'price': '500.0',
            'volume24h': '2459250000.0',
            'marketCap': '99000000.0',
            'percentChange1h': '9.2',
            'percentChange24h': '22.0',
            'percentChange7d': '20.0',
            'totalSupply': '40000000.0',
            'availableSupply': '40000000.0',
            'maxSupply': nil,
            'maxPrice': 10500.0,
            'liquidity': 'Very High',
            'inflationary': true,
            'growthPotential': 2000.0
          }
        }
      ].to_json)
    end
  end

  describe 'DELETE #destroy' do
    it 'removes an asset' do
      delete :destroy, params: { symbol: 'ETH' }
      expect(response).to have_http_status(:success)
    end
  end
end
