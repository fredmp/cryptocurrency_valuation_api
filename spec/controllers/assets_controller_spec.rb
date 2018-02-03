require 'rails_helper'

RSpec.describe AssetsController, type: :controller do

  before(:each) do
    allow(controller).to receive(:current_user) { build(:user) }
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
