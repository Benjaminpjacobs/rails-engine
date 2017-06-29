require 'rails_helper'

describe 'Customer invoice request' do
    it 'sends all customer invoices' do
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