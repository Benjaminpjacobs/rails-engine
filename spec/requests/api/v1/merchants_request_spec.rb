require 'rails_helper'

describe 'Merchants API' do
  context "GET /api/v1/merchants" do
    it 'sends all merchants' do
      create_list(:merchant, 5)

      get '/api/v1/merchants'

      expect(response).to be_success
      
      merchants = JSON.parse(response.body)
      merchant = merchants.first

      expect(merchants.count).to eq(5)
      expect(merchant).to have_key("name")
      expect(merchant["name"]).to be_a String
    end
  end
end
