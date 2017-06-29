require 'rails_helper'

describe 'Merchants API' do
  context "GET /api/v1/merchants" do
    it 'sends all merchants' do
      create_list(:merchant, 5)

      get '/api/v1/merchants'

      expect(response).to be_success
      
      merchants = JSON.parse(response.body)
      merchant = merchants.first

      expect(merchants.count).to eq(5)
      expect(merchant).to have_key("name")
      expect(merchant["name"]).to be_a String
    end
  end

  context "GET /api/v1/merchants/:id" do
    it 'sends one merchant' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant["id"]).to eq(merchant.id)
      expect(raw_merchant).to have_key("name")
      expect(raw_merchant["name"]).to be_a String
    end
  end

  context "GET /api/v1/merchants/find_all?params" do
    date = "2017-06-26 22:58:34 UTC"
    let(:merchant) { create(:merchant, created_at: date, updated_at: date) }

    it 'sends all merchants requested by id' do
      id_params = { id: merchant.id }

      get "/api/v1/merchants/find_all", params: id_params

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)
      expect(raw_merchant.count).to eq(1)

      expect(raw_merchant.first["id"]).to eq(merchant.id)
      expect(raw_merchant.first["name"]).to eq(merchant.name)
    end

    it 'sends all merchants requested by name case matching' do
      name_params = { name: merchant.name }
      get "/api/v1/merchants/find_all", params: name_params

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)
      expect(raw_merchant.count).to eq(1)

      expect(raw_merchant.first["id"]).to eq(merchant.id)
      expect(raw_merchant.first["name"]).to eq(merchant.name)
    end

    it 'sends all merchants requested by name case not matching' do
      name_params = { name: merchant.name.upcase }
      get "/api/v1/merchants/find_all", params: name_params

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)
      expect(raw_merchant.count).to eq(1)
      expect(raw_merchant.first["id"]).to eq(merchant.id)

      name_params = { name: merchant.name.capitalize }
      get "/api/v1/merchants/find_all", params: name_params

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)
      expect(raw_merchant.count).to eq(1)
      expect(raw_merchant.first["id"]).to eq(merchant.id)
    end

    it 'sends all merchants requested by created_at' do
      created_at_params = { created_at: merchant.created_at.to_s }

      get '/api/v1/merchants/find_all', params: created_at_params

      raw_merchant = JSON.parse(response.body)
      expect(raw_merchant.count).to eq(1)

      expect(raw_merchant.first["id"]).to eq(merchant.id)
      expect(raw_merchant.first["name"]).to eq(merchant.name)
    end

    it 'sends all merchants requested by updated_at' do
      updated_at_params = { updated_at: merchant.updated_at.to_s }

      get '/api/v1/merchants/find_all', params: updated_at_params

      raw_merchant = JSON.parse(response.body)
      expect(raw_merchant.count).to eq(1)

      expect(raw_merchant.first["id"]).to eq(merchant.id)
      expect(raw_merchant.first["name"]).to eq(merchant.name)
    end
  end

  context "GET /api/v1/merchants/find?params" do
    date = "2017-06-26 22:58:34 UTC"
    let(:merchant) { create(:merchant, created_at: date, updated_at: date) }

    it 'sends first merchant requested by id' do
      id_params = { id: merchant.id }

      get "/api/v1/merchants/find", params: id_params

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant["id"]).to eq(merchant.id)
      expect(raw_merchant["name"]).to eq(merchant.name)
    end

    it 'sends first merchant requested by name' do
      name_params = { name: merchant.name }
      get "/api/v1/merchants/find", params: name_params

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant["id"]).to eq(merchant.id)
      expect(raw_merchant["name"]).to eq(merchant.name)
    end

    it 'sends first merchant requested by name case not matching' do
      name_params = { name: merchant.name.upcase }
      get "/api/v1/merchants/find", params: name_params

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)
      expect(raw_merchant["id"]).to eq(merchant.id)

      name_params = { name: merchant.name.capitalize }
      get "/api/v1/merchants/find", params: name_params

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)
      expect(raw_merchant["id"]).to eq(merchant.id)
    end

    it 'sends first merchant requested by created_at' do
      created_at_params = { created_at: merchant.created_at.to_s }

      get '/api/v1/merchants/find', params: created_at_params

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant["id"]).to eq(merchant.id)
      expect(raw_merchant["name"]).to eq(merchant.name)
    end

    it 'sends first merchant requested by updated_at' do
      updated_at_params = { updated_at: merchant.updated_at.to_s }

      get '/api/v1/merchants/find', params: updated_at_params

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant["id"]).to eq(merchant.id)
      expect(raw_merchant["name"]).to eq(merchant.name)
    end
  end
end
