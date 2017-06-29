require 'rails_helper'

describe "Items Business Intelligence Endpoints" do
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
