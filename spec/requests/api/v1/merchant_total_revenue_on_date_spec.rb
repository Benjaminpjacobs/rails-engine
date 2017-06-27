require 'rails_helper'

describe 'Merchant Revenue API' do
  it 'sends total merchant revenue on date' do
    date = "2012-03-16 11:55:05"
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: date.to_datetime)
    invoice_item = create(:invoice_item, invoice_id: invoice.id, unit_price: 1025, quantity: 5)

    get "/api/v1/merchants/revenue?date=#{date}"

    expect(response).to be_success
    
    revenue = JSON.parse(response.body)

    expect(revenue).to eq({"total_revenue" => "51.25"})
  end
end