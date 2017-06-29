require 'rails_helper'

describe '/merchant/:id/association API requests' do
  context 'GET /api/v1/merchants/:id/items' do
    it 'returns a collection of items associated with that merchant' do
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

  context 'GET /api/v1/merchants/:id/invoices' do
    it 'returns a collection of invoices associated with that merchant from their known orders' do
      merchant = create(:merchant)
      create_list(:invoice, 5, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      expect(response).to be_success
      
      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(invoices.count).to eq(5)
      expect(invoice).to have_key("merchant_id")
      expect(invoice).to have_key("customer_id")
      expect(invoice).to have_key("status")
      expect(invoice["status"]).to be_a String
    end
  end
end
