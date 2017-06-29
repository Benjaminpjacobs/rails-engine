require 'rails_helper'

describe 'Transactions Invoice Request' do
    it 'sends associated invoice' do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      expect(response).to be_success
      
      invoice_response =  JSON.parse(response.body)

      expect(invoice_response["customer_id"]).to eq(invoice.customer_id)
      expect(invoice_response["merchant_id"]).to eq(invoice.merchant_id)
      expect(invoice_response["status"]).to eq(invoice.status)
    end
  end