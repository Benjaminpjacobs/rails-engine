require 'rails_helper'

describe '/customers/:id/association API requests' do
  context 'GET /api/v1/customers/:id/invoices' do
    it 'returns a collection of associated invoices' do
      customer = create(:customer)
      create_list(:invoice, 5, customer_id: customer.id)

      get "/api/v1/customers/#{customer.id}/invoices"

      expect(response).to be_success
      
      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(invoices.count).to eq(5)
      expect(invoice).to have_key("customer_id")
      expect(invoice).to have_key("merchant_id")
      expect(invoice).to have_key("status")
      expect(invoice["status"]).to be_a String
    end
  end

  context 'GET /api/v1/customers/:id/transactions' do
    it 'returns a collection of associated transactions' do
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id)
      create_list(:transaction, 5, invoice_id: invoice.id)

      get "/api/v1/customers/#{customer.id}/transactions"

      expect(response).to be_success
      
      transactions = JSON.parse(response.body)
      transaction = transactions.first

      expect(transactions.count).to eq(5)
      expect(transaction).to have_key("credit_card_number")
      expect(transaction).to have_key("result")
      expect(transaction["result"]).to be_a String
    end
  end
end


