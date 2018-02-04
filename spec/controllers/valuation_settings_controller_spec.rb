require 'rails_helper'

RSpec.describe ValuationSettingsController, type: :controller do

  let(:innovation) { create(:innovation) }

  before(:each) do
    allow(controller).to receive(:current_user) { innovation.user }
  end

  describe 'DELETE #destroy' do
    it 'removes a valuation setting' do
      delete :destroy, params: { id: innovation.id }

      expect(response).to have_http_status(:success)
      expect(response.status).to eq(204)
    end
  end

  describe 'PATCH update' do
    it 'udpates a valuation setting' do
      patch :update, params: {
        id: innovation.id,
        valuation_setting: {
          description: 'How much innovative is the coin?',
          max_value: 5,
          weight: 20
        }
      }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq({
        "id": innovation.id,
        "name": "Innovation",
        "description": 'How much innovative is the coin?',
        "maxValue": 5,
        "weight": "20.0"
      }.to_json)
    end
  end

  describe 'POST #batch_create' do
    it 'creates a set of valuation settings' do
      post :batch_create, params: {
        batch: [
          {
            name: 'Fees',
            description: 'Does it have acceptable fee rates?',
            max_value: 5,
            weight: 20
          },
          {
            name: 'Roadmap',
            description: 'Does it have a good roadmap?',
            max_value: 10,
            weight: 10
          }
        ]
      }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq([
        {
          "id": ValuationSetting.where(name: 'Fees').first.id,
          "name": "Fees",
          "description": "Does it have acceptable fee rates?",
          "maxValue": 5,
          "weight": "20.0"
        },
        {
          "id": ValuationSetting.where(name: 'Roadmap').first.id,
          "name": "Roadmap",
          "description": "Does it have a good roadmap?",
          "maxValue": 10,
          "weight": "10.0"
        }
      ].to_json)
    end
  end

  describe 'POST #create' do
    it 'creates a valuation setting' do
      post :create, params: {
        valuation_setting: {
          name: 'Fees',
          description: 'Does it have acceptable fee rates?',
          max_value: 5,
          weight: 20
        }
      }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq({
        "id": ValuationSetting.where(name: 'Fees').first.id,
        "name": "Fees",
        "description": "Does it have acceptable fee rates?",
        "maxValue": 5,
        "weight": "20.0"
      }.to_json)
    end
  end

  describe 'GET #index' do
    it 'returns valuation settings' do
      get :index

      expect(response).to have_http_status(:success)
      expect(response.body).to eq([
        {
          "id": innovation.id,
          "name": "Innovation",
          "description": nil,
          "maxValue": 10,
          "weight": "40.0"
        }
      ].to_json)
    end
  end

end
