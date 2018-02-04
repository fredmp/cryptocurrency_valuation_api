require 'rails_helper'

RSpec.describe ValuationsController, type: :controller do

  let(:wallet_valuation) { create(:wallet_valuation) }

  before(:each) do
    allow(controller).to receive(:current_user) { wallet_valuation.tracked_currency.user }
  end

  describe 'GET #update' do
    it 'updates a valuation' do
      post :update, params: { id: wallet_valuation.id, value: 5 }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq({
        "id": wallet_valuation.id,
        "value": 5,
        "valuationSetting": {
          "id": wallet_valuation.valuation_setting.id,
          "name": "Innovation",
          "description": nil,
          "maxValue": 10,
          "weight": "40.0"
        }
      }.to_json)
    end
  end

end
