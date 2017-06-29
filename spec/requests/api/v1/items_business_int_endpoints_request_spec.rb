require 'rails_helper'

describe "items business intelligence API requests" do
  context 'GET /api/v1/items/most_items?quantity=x' do
    it 'returns the top x item instances ranked by total number sold' do
      item1, item2, item3 = create_list(:item, 3)
      invoice1, invoice2, invoice3, invoice4, invoice5, invoice6= create_list(:invoice, 6)
      create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)
      create(:invoice_item, item_id: item2.id, invoice_id: invoice3.id)
      create(:invoice_item, item_id: item3.id, invoice_id: invoice4.id)
      create(:invoice_item, item_id: item3.id, invoice_id: invoice5.id)
      create(:invoice_item, item_id: item3.id, invoice_id: invoice6.id)

      get '/api/v1/items/most_items?quantity=2'
      expect(response).to be_success

      items = JSON.parse(response.body)
      expect(items.count).to eq(2)
      
      first_item = items.first
      second_item = items.last

      expect(first_item["id"]).to eq(item3.id)
      expect(first_item["name"]).to eq(item3.name)
      expect(second_item["id"]).to eq(item2.id)
      expect(second_item["name"]).to eq(item2.name)
    end
  end
end
