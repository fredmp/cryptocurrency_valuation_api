require 'rails_helper'

RSpec.describe TrackedCurrenciesController, type: :controller do

  let(:tracked_currency) { create(:tracked_currency) }

  before(:each) do
    allow(controller).to receive(:current_user) { tracked_currency.user }
  end

  describe 'GET #ids' do
    it 'returns IDs of tracked currencies' do
      get :ids

      expect(response).to have_http_status(:success)
      expect(response.body).to eq([tracked_currency.currency.id].to_json)
    end
  end

  describe 'DELETE #destroy' do
    it 'removes an existing tracked currency' do
      delete :destroy, params: { symbol: 'ETH' }

      expect(response).to have_http_status(:success)
      expect(response.status).to eq(204)
    end
  end

  describe 'PATCH #update' do
    it 'updates an existing tracked currency' do
      patch :update, params: { symbol: 'ETH', notes: 'Some notes' }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq({
        'id': tracked_currency.id,
        'expectedPrice': '500.0',
        'expectedGrowth': 0,
        'notes': 'Some notes',
        'currency': {
          'id': tracked_currency.currency.id,
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
        },
        'valuations': []
      }.to_json)
    end
  end

  describe 'POST #create' do
    it 'creates a new tracked currency' do
      ltc = create(:ltc)

      post :create, params: { symbol: 'LTC' }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq({
        "id": TrackedCurrency.where(currency_id: ltc.id).last.id,
        "expectedPrice": "280.0",
        "expectedGrowth": 0,
        "notes": nil,
        "currency": {
          "id": ltc.id,
          "rank": 5,
          "symbol": "LTC",
          "name": "Litecoin",
          "price": "280.0",
          "volume24h": "99000000.0",
          "marketCap": "20000000.0",
          "percentChange1h": "8.2",
          "percentChange24h": "2.2",
          "percentChange7d": "48.0",
          "totalSupply": "74000000.0",
          "availableSupply": "74000000.0",
          "maxSupply": "84000000.0",
          "maxPrice": 5000.0,
          "liquidity": "Medium",
          "inflationary": false,
          "growthPotential": 1685.71
        },
        "valuations": []
      }.to_json)
    end
  end

  describe 'GET #index' do
    it 'returns http 200 and tracked currencies' do
      get :index

      expect(response).to have_http_status(:success)
      expect(response.body).to eq([
        {
          'id': tracked_currency.id,
          'expectedPrice': '500.0',
          'expectedGrowth': 0,
          'notes': nil,
          'currency': {
            'id': tracked_currency.currency.id,
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
          },
          'valuations': []
        }
      ].to_json)
    end
  end

end
