require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }

  before(:each) do
    allow(controller).to receive(:current_user) { user }
  end

  describe 'POST #password_recovery' do
    it 'sends a recovery password email' do
      allow(User).to receive(:where).with(email: user.email).and_return([user])
      allow(JsonWebToken).to receive(:encode).with(user, kind_of(Time)).and_return('token')
      allow(UserMailer).to receive(:password_recovery).and_return(OpenStruct.new(deliver: true))

      post :password_recovery, params: { email: user.email }

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #redefine_password' do
    it 'changes user password if token is valid' do
      user.token = 'token'
      allow(JsonWebToken).to receive(:decode).with('token').and_return({ user_id: user.id })
      allow(User).to receive(:find).with(user.id).and_return(user)

      post :redefine_password, params: { token: user.token, password: '123456' }

      expect(response).to have_http_status(:success)
    end
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
