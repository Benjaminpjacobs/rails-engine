require 'rails_helper'

describe 'Transactions API' do
  context "GET /api/v1/transactions" do
    it 'sends all merchants' do
      create_list(:transaction, 5)

      get '/api/v1/transactions'

      expect(response).to be_success
      
      transactions =  JSON.parse(response.body)
      transaction = transactions.first

      expect(transactions.count).to eq(5)
      expect(transaction).to have_key("name")
      expect(transaction["name"]).to be_a String
    end
  end
end
