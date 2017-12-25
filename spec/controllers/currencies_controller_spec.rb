require 'rails_helper'

RSpec.describe CurrenciesController, type: :controller do

  describe "GET #index" do
    it "returns http 200 and stored currencies" do
      create(:btc)
      create(:eth)
      get :index
      expect(response).to have_http_status(:success)
      expect(
        response.body
      ).to eq(
        [
          {
            "rank" => 1,
            "symbol" => "BTC",
            "name" => "Bitcoin",
            "price" => "20000.0",
            "volume24h" => "10574600000.0",
            "marketCap" => "200000000000.0",
            "percentChange1h" => "20.2",
            "percentChange24h" => "14.2",
            "percentChange7d" => "8.8",
            "totalSupply" => "14000000.0",
            "availableSupply" => "14000000.0",
            "maxSupply" => "21000000.0",
            "maxPrice" => 20000.0,
            "fairPrice" => 20000.0,
            "liquidity" => "Very High",
            "inflationary" => false,
            "growthPotential" => 0.0
          },
          {
            "rank" => 2,
            "symbol" => "ETH",
            "name" => "Ethereum",
            "price" => "500.0",
            "volume24h" => "2459250000.0",
            "marketCap" => "99000000.0",
            "percentChange1h" => "9.2",
            "percentChange24h" => "22.0",
            "percentChange7d" => "20.0",
            "totalSupply" => "40000000.0",
            "availableSupply" => "40000000.0",
            "maxSupply" => nil,
            "maxPrice" => 10500.0,
            "fairPrice" => 5250.0,
            "liquidity" => "Very High",
            "inflationary" => true,
            "growthPotential" => 950.0
          }
        ].to_json
      )
    end
  end

end
