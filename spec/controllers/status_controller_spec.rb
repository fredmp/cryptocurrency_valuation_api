require 'rails_helper'

RSpec.describe StatusController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      allow(ActiveRecord::Base).to receive(:connection).and_return(OpenStruct.new(current_database: 'postgresql'))

      get :index
      expect(response).to have_http_status(:success)
      expect(response.code).to eq('200')
      expect(response.body).to eq({ status: 'ok' }.to_json)
    end

    it 'returns http failure' do
      allow(ActiveRecord::Base).to receive(:connection).and_raise('PG::ConnectionBad')

      get :index
      expect(response).to have_http_status(:error)
      expect(response.code).to eq('503')
      expect(response.body).to eq('')
    end
  end

end
