require 'rails_helper'

describe 'Merchant Invoice API' do
  it 'sends all merchant invoices' do
    merchant = create(:merchant)
    create_list(:invoice, 5, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_success
    
    invoices = JSON.parse(response.body)
    invoice = invoices.first

    expect(invoices.count).to eq(5)
    expect(invoice).to have_key("merchant_id")
    expect(invoice).to have_key("customer_id")
    expect(invoice).to have_key("status")
    expect(invoice["status"]).to be_a String
  end
end
