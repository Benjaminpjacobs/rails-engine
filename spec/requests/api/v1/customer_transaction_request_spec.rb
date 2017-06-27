require 'rails_helper'

describe 'Customer transaction request' do
    it 'sends all customer transactions' do
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