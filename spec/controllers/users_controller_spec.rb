require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }

  before(:each) do
    allow(controller).to receive(:current_user) { user }
  end

  describe 'PATCH #update' do
    it 'updates a user' do
      patch :update, params: { id: user.id, user: { name: 'Updated User' } }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq({
        'id': user.id,
        'email': 'user@domain.com',
        'name': 'Updated User',
        'localCurrency': nil
      }.to_json)
    end
  end

  describe 'GET #create' do
    it 'creates a new user' do
      post :create, params: {
        user: {
          name: 'User',
          email: 'myself@domain.com',
          local_currency: 'BRL'
        },
        password: '123456'
      }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq({
        'id': User.where(email: 'myself@domain.com').last.id,
        'email': 'myself@domain.com',
        'name': 'User',
        'localCurrency': 'BRL'
      }.to_json)
    end
  end

end
