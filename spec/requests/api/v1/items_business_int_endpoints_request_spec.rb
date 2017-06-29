require 'rails_helper'

describe "Items Business Intelligence API requests" do
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
  
  context 'GET /api/v1/items/most_revenue?quantity=x' do
    it 'returns the top x items ranked by total revenue generated' do
      item1, item2, item3, item4= create_list(:item, 4)
      invoice1, invoice2= create_list(:invoice, 4)
      create(:invoice_item, invoice_id: invoice1.id, item_id: item1.id, unit_price: 1000, quantity: 5)
      create(:invoice_item, invoice_id: invoice1.id, item_id: item2.id, unit_price: 1000, quantity: 4)
      create(:invoice_item, invoice_id: invoice2.id, item_id: item3.id, unit_price: 1000, quantity: 3)
      create(:invoice_item, invoice_id: invoice2.id, item_id: item4.id, unit_price: 1000, quantity: 2)


      get '/api/v1/items/most_revenue?quantity=2'

      expect(response).to be_success

      items = JSON.parse(response.body)
      item = items.first

      expect(items.count).to eq(2)
      expect(item['id']).to eq(item1.id)
      expect(item['name']).to eq(item1.name)
    end
  end

  context 'GET /api/v1/items/:id/best_day' do
    it 'returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.' do
      date1 = "2012-03-22T03:55:09.000Z"
      date2 = "2012-03-22T03:55:09.000Z"
      item = create(:item)
      invoice1, invoice2, invoice3 = create_list(:invoice, 3, created_at: date1)
      invoice4, invoice5 = create_list(:invoice, 2, created_at: date2)
      create(:invoice_item, item_id: item.id, invoice_id: invoice1.id)
      create(:invoice_item, item_id: item.id, invoice_id: invoice2.id)
      create(:invoice_item, item_id: item.id, invoice_id: invoice3.id)
      create(:invoice_item, item_id: item.id, invoice_id: invoice4.id)
      create(:invoice_item, item_id: item.id, invoice_id: invoice5.id)

      get "/api/v1/items/#{item.id}/best_day"

      expect(response).to be_success

      date = JSON.parse(response.body)

      expect(date["best_day"]).to eq(date1)
    end
  end
end
