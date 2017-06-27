require 'rails_helper'

describe "Item API request" do
  it "sends a list of items ranked by revenue generated" do
    item1, item2, item3, item4= create_list(:item, 4)
    invoice1, invoice2= create_list(:invoice, 4)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, unit_price: 1000, quantity: 5)
    invoice_item2 = create(:invoice_item, invoice_id: invoice1.id, item_id: item2.id, unit_price: 1000, quantity: 4)
    invoice_item3 = create(:invoice_item, invoice_id: invoice2.id, item_id: item3.id, unit_price: 1000, quantity: 3)
    invoice_item4 = create(:invoice_item, invoice_id: invoice2.id, item_id: item4.id, unit_price: 1000, quantity: 2)


    get '/api/v1/items/most_revenue?quantity=2'

    expect(response).to be_success

    items = JSON.parse(response.body)
    item = items.first

    expect(items.count).to eq(2)
    expect(item['id']).to eq(item1.id)
    expect(item['name']).to eq(item1.name)
  end
end
