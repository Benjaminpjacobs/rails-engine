require 'rails_helper'

describe "Item API request" do
  it "sends a list of items " do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_success

    items = JSON.parse(response.body)
    item = items.first

    expect(items.count).to eq(3)
    expect(item).to have_key("name")
    expect(item).to have_key("description")
    expect(item).to have_key("unit_price")
    expect(item).to have_key("merchant_id")
  end

  it "sends a single invoices " do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_success

    item_response = JSON.parse(response.body)
    expect(item_response["name"]).to eq(item.name)
    expect(item_response["description"]).to eq(item.description)
    expect(item_response["unit_price"]).to eq(item.unit_price)
    expect(item_response["merchant_id"]).to eq(item.merchant_id)
    
  end
end
