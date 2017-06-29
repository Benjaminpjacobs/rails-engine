require 'rails_helper'

describe "Item API" do
  context 'GET /api/v1/items' do
    it "sends a list of all items " do
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
  end

  context 'GET /api/v1/items/:id' do
    it "sends a single item " do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      expect(response).to be_success

      item_response = JSON.parse(response.body)
      expect(item_response["name"]).to eq(item.name)
      expect(item_response["description"]).to eq(item.description)
      expect(item_response["unit_price"]).to eq((item.unit_price.to_f/100).to_s)
      expect(item_response["merchant_id"]).to eq(item.merchant_id)
    end
  end

  context 'GET /api/v1/items/find?params' do
    let(:date) { "2017-06-26 22:58:34 UTC" }
    let(:item) { create(:item, created_at: date, updated_at: date) }
      
    it "finds an item based on name case matching" do
      get "/api/v1/items/find?name=#{item.name}"
      expect(response).to be_success
      items_response = JSON.parse(response.body)
      expect(items_response["id"]).to eq(item.id)
    end
      
    it 'finds an item based on name case insensitive' do
      get "/api/v1/items/find?name=#{item.name.upcase}"
      expect(response).to be_success
      items_response = JSON.parse(response.body)
      expect(items_response["id"]).to eq(item.id)
    end

    it 'finds an item based on descripion case matching' do
      get "/api/v1/items/find?description=#{item.description}"
      expect(response).to be_success
      items_response = JSON.parse(response.body)
      expect(items_response["id"]).to eq(item.id)
    end

    it 'finds an item based on description case insensitive' do
      get "/api/v1/items/find?description=#{item.description.upcase}"
      expect(response).to be_success
      items_response = JSON.parse(response.body)
      expect(items_response["id"]).to eq(item.id)
    end

    it 'finds an item based on unit prices' do
      get "/api/v1/items/find?unit_price=#{item.unit_price.to_f/100}"
      expect(response).to be_success
      items_response = JSON.parse(response.body)
      expect(items_response["id"]).to eq(item.id)
    end
      
    it 'finds an item based on merchant id' do
      get "/api/v1/items/find?merchant_id=#{item.merchant_id.to_s}"
      expect(response).to be_success
      items_response = JSON.parse(response.body)
      expect(items_response["id"]).to eq(item.id)
    end
      
    it 'finds an item based on created at date' do
      get "/api/v1/items/find?created_at=#{item.created_at.to_s}"
      expect(response).to be_success
      items_response = JSON.parse(response.body)
      expect(items_response["id"]).to eq(item.id)
    end
      
    it 'finds an item based on updated at date' do
      get "/api/v1/items/find?updated_at=#{item.updated_at.to_s}"
      expect(response).to be_success
      items_response = JSON.parse(response.body)
      expect(items_response["id"]).to eq(item.id)
    end
  end

  context 'get /api/v1/items/find_all?params' do
    it "finds all items based on item id" do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      
      item1, item2 = create_list(:item, 2, merchant_id: merchant1.id, name: "Thingy", description: "This thing is cool", created_at: date, updated_at: date)

      item3, item4 = create_list(:item, 2, merchant_id: merchant2.id, name: "Thinger", description: "Also a cool thing", unit_price: 1000, created_at: date2, updated_at: date2)


      get "/api/v1/items/find_all?id=#{item1.id}"
      expect(response).to be_success
      item_response = JSON.parse(response.body)
      expect(item_response.count).to eq(1)
      expect(item_response.first["id"]).to eq(item1.id)
    end

    it 'finds all items based on item name case matching' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      
      item1, item2 = create_list(:item, 2, merchant_id: merchant1.id, name: "Thingy", description: "This thing is cool", created_at: date, updated_at: date)

      item3, item4 = create_list(:item, 2, merchant_id: merchant2.id, name: "Thinger", description: "Also a cool thing", unit_price: 1000, created_at: date2, updated_at: date2)

      get "/api/v1/items/find_all?name=#{item1.name}"
      expect(response).to be_success
      item_response = JSON.parse(response.body)
      expect(item_response.count).to eq(2)
      expect(item_response.first["id"]).to eq(item1.id)
      expect(item_response.last["id"]).to eq(item2.id)
    end

    it 'finds all items based on item name case insenstitive' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      
      item1, item2 = create_list(:item, 2, merchant_id: merchant1.id, name: "Thingy", description: "This thing is cool", created_at: date, updated_at: date)

      item3, item4 = create_list(:item, 2, merchant_id: merchant2.id, name: "Thinger", description: "Also a cool thing", unit_price: 1000, created_at: date2, updated_at: date2)

      get "/api/v1/items/find_all?name=#{item1.name.upcase}"
      expect(response).to be_success
      item_response = JSON.parse(response.body)
      expect(item_response.count).to eq(2)
      expect(item_response.first["id"]).to eq(item1.id)
      expect(item_response.last["id"]).to eq(item2.id)
    end
      

    it 'finds all items based on item description case matching' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      
      item1, item2 = create_list(:item, 2, merchant_id: merchant1.id, name: "Thingy", description: "This thing is cool", created_at: date, updated_at: date)

      item3, item4 = create_list(:item, 2, merchant_id: merchant2.id, name: "Thinger", description: "Also a cool thing", unit_price: 1000, created_at: date2, updated_at: date2)
      
      get "/api/v1/items/find_all?description=#{item3.description}"
      expect(response).to be_success
      item_response = JSON.parse(response.body)
      expect(item_response.count).to eq(2)
      expect(item_response.first["id"]).to eq(item3.id)
      expect(item_response.last["id"]).to eq(item4.id)
    end

    it 'finds all items based on description case insensitive' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      
      item1, item2 = create_list(:item, 2, merchant_id: merchant1.id, name: "Thingy", description: "This thing is cool", created_at: date, updated_at: date)

      item3, item4 = create_list(:item, 2, merchant_id: merchant2.id, name: "Thinger", description: "Also a cool thing", unit_price: 1000, created_at: date2, updated_at: date2)

      get "/api/v1/items/find_all?description=#{item3.description.upcase}"
      expect(response).to be_success
      item_response = JSON.parse(response.body)
      expect(item_response.count).to eq(2)
      expect(item_response.first["id"]).to eq(item3.id)
      expect(item_response.last["id"]).to eq(item4.id)
    end

    it 'finds all items based on unit price' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      
      item1, item2 = create_list(:item, 2, merchant_id: merchant1.id, name: "Thingy", description: "This thing is cool", created_at: date, updated_at: date)

      item3, item4 = create_list(:item, 2, merchant_id: merchant2.id, name: "Thinger", description: "Also a cool thing", unit_price: 1000, created_at: date2, updated_at: date2)

      get "/api/v1/items/find_all?unit_price=#{item1.unit_price.to_f/100}"
      expect(response).to be_success
      item_response = JSON.parse(response.body)
      expect(item_response.count).to eq(2)
      expect(item_response.first["id"]).to eq(item1.id)
      expect(item_response.last["id"]).to eq(item2.id)
    end

    it 'finds all items based on merchant id' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      
      item1, item2 = create_list(:item, 2, merchant_id: merchant1.id, name: "Thingy", description: "This thing is cool", created_at: date, updated_at: date)

      item3, item4 = create_list(:item, 2, merchant_id: merchant2.id, name: "Thinger", description: "Also a cool thing", unit_price: 1000, created_at: date2, updated_at: date2)

      get "/api/v1/items/find_all?merchant_id=#{merchant1.id}"
      expect(response).to be_success
      item_response = JSON.parse(response.body)
      expect(item_response.count).to eq(2)
      expect(item_response.first["id"]).to eq(item1.id)
      expect(item_response.last["id"]).to eq(item2.id)
    end

    it 'finds all items based on created at date' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      
      item1, item2 = create_list(:item, 2, merchant_id: merchant1.id, name: "Thingy", description: "This thing is cool", created_at: date, updated_at: date)

      item3, item4 = create_list(:item, 2, merchant_id: merchant2.id, name: "Thinger", description: "Also a cool thing", unit_price: 1000, created_at: date2, updated_at: date2)

      get "/api/v1/items/find_all?created_at=#{date.to_s}"
      expect(response).to be_success
      item_response = JSON.parse(response.body)
      expect(item_response.count).to eq(2)
      expect(item_response.first["id"]).to eq(item1.id)
      expect(item_response.last["id"]).to eq(item2.id)
    end
      
    it 'finds all items baased on updated at date' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      
      item1, item2 = create_list(:item, 2, merchant_id: merchant1.id, name: "Thingy", description: "This thing is cool", created_at: date, updated_at: date)

      item3, item4 = create_list(:item, 2, merchant_id: merchant2.id, name: "Thinger", description: "Also a cool thing", unit_price: 1000, created_at: date2, updated_at: date2)

      get "/api/v1/items/find_all?updated_at=#{date2.to_s}"
      expect(response).to be_success
      item_response = JSON.parse(response.body)
      expect(item_response.count).to eq(2)
      expect(item_response.first["id"]).to eq(item3.id)
      expect(item_response.last["id"]).to eq(item4.id)
    end
  end
  context 'GET /api/v1/items/random' do
    it 'sends a random item' do
      create_list(:item, 5)
      get '/api/v1/items/random'

      expect(response).to be_success

      raw_data = JSON.parse(response.body)
      expect(raw_data).to have_key("id")
    end
  end
end
