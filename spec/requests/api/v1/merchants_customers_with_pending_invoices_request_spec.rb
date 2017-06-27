require 'rails_helper'

describe "Merchants customers with pending invoices" do
  it "returns customers with pending invoices" do
    merchant = create(:merchant)
    customer1, customer2 = create_list(:customer, 2)
    invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
    invoice2 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: "failed")
    transaction3 = create(:transaction, invoice_id: invoice2.id, result: "failed")

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    expect(response).to be_success

    customers_response = JSON.parse(response.body)
    expect(customers_response.count).to eq(1)
    customer = customers_response.first

    expect(customer["id"]).to eq(customer2.id)
  end
end

