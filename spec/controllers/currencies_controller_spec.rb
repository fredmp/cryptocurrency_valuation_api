require 'rails_helper'

RSpec.describe CurrenciesController, type: :controller do

  before(:each) do
    allow(controller).to receive(:current_user) { build(:user) }
  end

  describe 'DELETE #clean_up' do
    it 'removes old currency update entries' do
      ENV['ADMIN_TOKEN'] = '1234'
      request.headers.merge!({ 'Authorization' => '1234' })

      delete :clean_up

      expect(response).to have_http_status(:success)
      expect(response.body).to eq({ message: 'Old currency update entries were removed' }.to_json)
    end
  end

  describe 'POST #batch_update' do
    it 'updates a set of currencies with fresh new info' do
      result = { status: :success, timestamp: '2018-01-20', offset: 0, limit: 100 }
      allow_any_instance_of(DataUpdater).to receive(:execute).and_return(result)
      ENV['ADMIN_TOKEN'] = '1234'
      request.headers.merge!({ 'Authorization' => '1234' })

      post :batch_update, params: { offset: 0 }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(result.to_json)
    end
  end

  describe 'GET #index' do
    it 'returns http 200 and stored currencies' do
      btc = create(:btc)
      eth = create(:eth)

      get :index

      expect(response).to have_http_status(:success)
      expect(
        response.body
      ).to eq(
        [
          {
            'id' => btc.id,
            'rank' => 1,
            'symbol' => 'BTC',
            'name' => 'Bitcoin',
            'price' => '20000.0',
            'volume24h' => '10574600000.0',
            'marketCap' => '200000000000.0',
            'percentChange1h' => '20.2',
            'percentChange24h' => '14.2',
            'percentChange7d' => '8.8',
            'totalSupply' => '14000000.0',
            'availableSupply' => '14000000.0',
            'maxSupply' => '21000000.0',
            'maxPrice' => 20000.0,
            'liquidity' => 'Very High',
            'inflationary' => false,
            'growthPotential' => 0.0
          },
          {
            'id' => eth.id,
            'rank' => 2,
            'symbol' => 'ETH',
            'name' => 'Ethereum',
            'price' => '500.0',
            'volume24h' => '2459250000.0',
            'marketCap' => '99000000.0',
            'percentChange1h' => '9.2',
            'percentChange24h' => '22.0',
            'percentChange7d' => '20.0',
            'totalSupply' => '40000000.0',
            'availableSupply' => '40000000.0',
            'maxSupply' => nil,
            'maxPrice' => 10500.0,
            'liquidity' => 'Very High',
            'inflationary' => true,
            'growthPotential' => 2000.0
          }
        ].to_json
      )
    end
  end

end
