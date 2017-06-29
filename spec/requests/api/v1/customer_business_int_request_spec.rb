require 'rails_helper'

describe 'Customer Business Intelligence Endpoints' do
  context 'GET /api/v1/customers/:id/favorite_merchant' do
    it 'returns a merchant where the customer has conducted the most successful transactions' do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      create(:transaction, invoice_id: invoice1.id)
      create(:transaction, invoice_id: invoice2.id)
      create(:transaction, invoice_id: invoice3.id)

      get "/api/v1/customers/#{customer.id}/favorite_merchant"
      expect(response).to be_succes

      recieved = JSON.parse(response.body)

      expect(recieved["id"]).to eq(merchant1.id)
      expect(recieved["name"]).to eq(merchant1.name)
    end
  end
end
