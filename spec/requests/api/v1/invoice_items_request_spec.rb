require 'rails_helper'

describe "Invoice Items API" do
  context 'GET /api/v1/invoice_items' do
    it "sends a list of all invoice items " do
      create_list(:invoice_item, 3)

      get '/api/v1/invoice_items'

      expect(response).to be_success

      invoice_items = JSON.parse(response.body)
      invoice_item = invoice_items.first

      expect(invoice_items.count).to eq(3)
      expect(invoice_item).to have_key("item_id")
      expect(invoice_item).to have_key("invoice_id")
      expect(invoice_item).to have_key("unit_price")
    end
  end

  context 'GET /api/v1/invoice_items/:id' do
    it "sends a single invoice item " do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/#{invoice_item.id}"

      expect(response).to be_success

      ii_response = JSON.parse(response.body)
      expect(ii_response["item_id"]).to eq(invoice_item.item_id)
      expect(ii_response["invoice_id"]).to eq(invoice_item.invoice_id)
      expect(ii_response["unit_price"]).to eq((invoice_item.unit_price.to_f/100).to_s)
    end
  end

  context 'GET /api/v1/invoice_items/find?params' do
    date = "2017-06-26 22:58:34 UTC"
    let(:invoice_item) { create(:invoice_item, created_at: date, updated_at: date) }

    it "sends first invoice_item based on item id" do
      date = "2017-06-26 22:58:34 UTC"
      invoice_item = create(:invoice_item, created_at: date, updated_at: date)

      get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"
      expect(response).to be_success
      ii_response = JSON.parse(response.body)
      expect(ii_response["id"]).to eq(invoice_item.id)
    end

    it 'send first invoice_item based on invoice id' do
      get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"
      expect(response).to be_success
      ii_response = JSON.parse(response.body)
      expect(ii_response["id"]).to eq(invoice_item.id)
    end

    it 'send first invoice_item based on unit price' do
      get "/api/v1/invoice_items/find?unit_price=#{invoice_item.unit_price.to_f/100}"
      expect(response).to be_success
      items_response = JSON.parse(response.body)
      expect(items_response["id"]).to eq(invoice_item.id)
    end

    it 'sends first invoice_item based on item quantity' do
      get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"
      expect(response).to be_success
      items_response = JSON.parse(response.body)
      expect(items_response["id"]).to eq(invoice_item.id)
    end

    it 'send first invoice_item based on created date' do
      get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at.to_s}"
      expect(response).to be_success
      ii_response = JSON.parse(response.body)
      expect(ii_response["id"]).to eq(invoice_item.id)
    end
      
    it 'sends first invoice_item based on updated date' do
      get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at.to_s}"
      expect(response).to be_success
      ii_response = JSON.parse(response.body)
      expect(ii_response["id"]).to eq(invoice_item.id)
    end
  end

  context 'GET /api/v1/invoice_items/find_all?params' do
    it "sends all invoice_items based on item id" do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      item1, item2 = create_list(:item, 2)
      invoice1, invoice2 = create_list(:invoice, 2)
      
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, created_at: date, updated_at: date)
      invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id, created_at: date2, updated_at: date2)
      invoice_item3 = create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id, unit_price: 1000, created_at: date, updated_at: date)
      invoice_item4 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, unit_price: 1000, created_at: date2, updated_at: date2)
      get "/api/v1/invoice_items/find_all?item_id=#{item1.id}"
      expect(response).to be_success
      ii_response = JSON.parse(response.body)
      expect(ii_response.count).to eq(2)
      expect(ii_response.first["id"]).to eq(invoice_item1.id)
      expect(ii_response.last["id"]).to eq(invoice_item2.id)
    end

    it 'send all invoice_items based on invoice id' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      item1, item2 = create_list(:item, 2)
      invoice1, invoice2 = create_list(:invoice, 2)
      
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, created_at: date, updated_at: date)
      invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id, created_at: date2, updated_at: date2)
      invoice_item3 = create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id, unit_price: 1000, created_at: date, updated_at: date)
      invoice_item4 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, unit_price: 1000, created_at: date2, updated_at: date2)
      get "/api/v1/invoice_items/find_all?invoice_id=#{invoice1.id}"
      expect(response).to be_success
      ii_response = JSON.parse(response.body)
      expect(ii_response.count).to eq(2)
      expect(ii_response.first["id"]).to eq(invoice_item1.id)
      expect(ii_response.last["id"]).to eq(invoice_item3.id)
    end

    it 'sends all invoice_items based on unit price' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      item1, item2 = create_list(:item, 2)
      invoice1, invoice2 = create_list(:invoice, 2)
      
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, created_at: date, updated_at: date)
      invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id, created_at: date2, updated_at: date2)
      invoice_item3 = create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id, unit_price: 1000, created_at: date, updated_at: date)
      invoice_item4 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, unit_price: 1000, created_at: date2, updated_at: date2)
      get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item3.unit_price.to_f/100}"
      expect(response).to be_success
      ii_response = JSON.parse(response.body)
      expect(ii_response.count).to eq(2)
      expect(ii_response.first["id"]).to eq(invoice_item3.id)
      expect(ii_response.last["id"]).to eq(invoice_item4.id)
    end

    it 'sends all invoice_items based on created at date' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      item1, item2 = create_list(:item, 2)
      invoice1, invoice2 = create_list(:invoice, 2)
      
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, created_at: date, updated_at: date)
      invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id, created_at: date2, updated_at: date2)
      invoice_item3 = create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id, unit_price: 1000, created_at: date, updated_at: date)
      invoice_item4 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, unit_price: 1000, created_at: date2, updated_at: date2)
      get "/api/v1/invoice_items/find_all?created_at=#{date.to_s}"
      expect(response).to be_success
      ii_response = JSON.parse(response.body)
      expect(ii_response.count).to eq(2)
      expect(ii_response.first["id"]).to eq(invoice_item1.id)
      expect(ii_response.last["id"]).to eq(invoice_item3.id)
    end

    it 'sends all invoice_items based on updated at date' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      item1, item2 = create_list(:item, 2)
      invoice1, invoice2 = create_list(:invoice, 2)
      
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, created_at: date, updated_at: date)
      invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id, created_at: date2, updated_at: date2)
      invoice_item3 = create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id, unit_price: 1000, created_at: date, updated_at: date)
      invoice_item4 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id, unit_price: 1000, created_at: date2, updated_at: date2)
      get "/api/v1/invoice_items/find_all?updated_at=#{date2.to_s}"
      expect(response).to be_success
      ii_response = JSON.parse(response.body)
      expect(ii_response.count).to eq(2)
      expect(ii_response.first["id"]).to eq(invoice_item2.id)
      expect(ii_response.last["id"]).to eq(invoice_item4.id)
    end
  end
  context 'GET /api/v1/invoice_items/random' do
    it 'sends a random invoice_item' do
      create_list(:invoice_item, 5)
      get '/api/v1/invoice_items/random'

      expect(response).to be_success

      raw_data = JSON.parse(response.body)
      expect(raw_data).to have_key("id")
    end
  end
end
