require 'rails_helper'

describe 'Merchant Ranked RequestAPI' do
  it 'sends merchants ranked by total revenue' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)


    invoice1 = create(:invoice, merchant_id: merchant1.id)
    invoice2 = create(:invoice, merchant_id: merchant2.id)
    invoice3 = create(:invoice, merchant_id: merchant3.id)

    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id)

    create_list(:invoice_item, 6, invoice_id: invoice1.id)
    create_list(:invoice_item, 3, invoice_id: invoice2.id)
    create_list(:invoice_item, 1, invoice_id: invoice3.id)


    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_success
    
    merchants = JSON.parse(response.body)
    merchant = merchants.first
    second_merchant = merchants.last

    expect(merchants.count).to eq(2)
    expect(merchant['id']).to eq(merchant1.id)
    expect(merchant['name']).to eq(merchant1.name)
    expect(second_merchant['id']).to eq(merchant2.id)
    expect(second_merchant['name']).to eq(merchant2.name)
    
  end
end
