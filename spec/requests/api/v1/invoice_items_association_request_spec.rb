require 'rails_helper'

describe "invoice/:id/items API request" do
  it "sends a list of items for requested invoice" do
    invoice = create(:invoice)
    item1, item2, item3 = create_list(:item, 3)
    invoice.items.append(item1, item2, item3)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_success

    items = JSON.parse(response.body)
    item = items.first

    expect(items.count).to eq(3)
    expect(item).to have_key("name")
    expect(item).to have_key("description")
    expect(item).to have_key("unit_price")
    expect(item).to have_key("merchant_id")
  end
end
