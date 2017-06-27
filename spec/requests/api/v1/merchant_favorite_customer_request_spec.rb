require 'rails_helper'

describe "Merchants favorite customer" do
  it "returns customer with most total successful transaction" do
    merchant = create(:merchant)
    customer1, customer2 = create_list(:customer, 2)
    invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
    invoice2 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
    invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
    invoice4 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
    invoice5 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
    invoice6 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: "success")
    transaction3 = create(:transaction, invoice_id: invoice3.id, result: "failed")
    transaction4 = create(:transaction, invoice_id: invoice4.id, result: "success")
    transaction5 = create(:transaction, invoice_id: invoice5.id, result: "success")
    transaction5 = create(:transaction, invoice_id: invoice6.id, result: "success")
    

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(customer2.id)
  end
end

