require 'rails_helper'

describe 'Merchant Items API' do
  it 'sends all merchant items' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_success
    
    items = JSON.parse(response.body)
    item = items.first

    expect(items.count).to eq(5)
    expect(item).to have_key("name")
    expect(item).to have_key("description")
    expect(item).to have_key("unit_price")
    expect(item["name"]).to be_a String
    expect(item["description"]).to be_a String
  end
end
