require 'rails_helper'

describe 'Customers API' do
  context "GET /api/v1/customers" do
    it 'sends all customers' do
      create_list(:customer, 5)

      get '/api/v1/customers'

      expect(response).to be_success
      
      customers = JSON.parse(response.body)
      customer = customers.first

      expect(customers.count).to eq(5)
      expect(customer).to have_key("first_name")
      expect(customer).to have_key("last_name")
      expect(customer["first_name"]).to be_a String
      expect(customer["last_name"]).to be_a String
    end
  end

  context "GET /api/v1/customers/:id" do
    it 'sends one customer' do
      customer = create(:customer)

      get "/api/v1/customers/#{customer.id}"

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)

      expect(raw_customer["id"]).to eq(customer.id)
      expect(raw_customer).to have_key("first_name")
      expect(raw_customer).to have_key("last_name")
      expect(raw_customer["first_name"]).to be_a String
      expect(raw_customer["last_name"]).to be_a String
    end
  end

  context "GET /api/v1/customers/find_all?params" do
    date = "2017-06-26 22:58:34 UTC"
    let(:customer) { create(:customer, created_at: date, updated_at: date) }

    it 'sends all customers requested by id' do
      id_params = { id: customer.id }

      get "/api/v1/customers/find_all", params: id_params

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)
      expect(raw_customer.count).to eq(1)

      expect(raw_customer.first["id"]).to eq(customer.id)
    end

    it 'sends all customers requested by first_name case matching' do
      first_name_params = { first_name: customer.first_name }
      get "/api/v1/customers/find_all", params: first_name_params

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)
      expect(raw_customer.count).to eq(1)

      expect(raw_customer.first["id"]).to eq(customer.id)
    end

    it 'sends all customers requested by first_name case not matching' do
      first_name_params = { first_name: customer.first_name.upcase }
      get "/api/v1/customers/find_all", params: first_name_params

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)
      expect(raw_customer.count).to eq(1)

      expect(raw_customer.first["id"]).to eq(customer.id)
    end

    it 'sends all customers requested by last_name case matching' do
      last_name_params = { last_name: customer.last_name }
      get "/api/v1/customers/find_all", params: last_name_params

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)
      expect(raw_customer.count).to eq(1)

      expect(raw_customer.first["id"]).to eq(customer.id)
    end

    it 'sends all customers requested by last_name case not matching' do
      last_name_params = { last_name: customer.last_name.upcase }
      get "/api/v1/customers/find_all", params: last_name_params

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)
      expect(raw_customer.count).to eq(1)

      expect(raw_customer.first["id"]).to eq(customer.id)
    end

    it 'sends all customers requested by created_at' do
      created_at_params = { created_at: customer.created_at.to_s }

      get '/api/v1/customers/find_all', params: created_at_params

      raw_customer = JSON.parse(response.body)
      expect(raw_customer.count).to eq(1)

      expect(raw_customer.first["id"]).to eq(customer.id)
    end

    it 'sends all customers requested by updated_at' do
      updated_at_params = { updated_at: customer.updated_at.to_s }

      get '/api/v1/customers/find_all', params: updated_at_params

      raw_customer = JSON.parse(response.body)
      expect(raw_customer.count).to eq(1)

      expect(raw_customer.first["id"]).to eq(customer.id)
    end
  end

  context "GET /api/v1/customers/find?params" do
    date = "2017-06-26 22:58:34 UTC"
    let(:customer) { create(:customer, created_at: date, updated_at: date) }

    it 'sends first customer requested by id' do
      id_params = { id: customer.id }

      get "/api/v1/customers/find", params: id_params

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)

      expect(raw_customer["id"]).to eq(customer.id)
    end

    it 'sends first customer requested by first_name matching' do
      first_name_params = { first_name: customer.first_name }
      get "/api/v1/customers/find", params: first_name_params

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)

      expect(raw_customer["id"]).to eq(customer.id)
      expect(raw_customer["first_name"]).to eq(customer.first_name)
    end

    it 'sends first customer requested by first_name not matching' do
      first_name_params = { first_name: customer.first_name.upcase }
      get "/api/v1/customers/find", params: first_name_params

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)

      expect(raw_customer["id"]).to eq(customer.id)
      expect(raw_customer["first_name"]).to eq(customer.first_name)
    end

    it 'sends first customer requested by last_name case matching' do
      last_name_params = { last_name: customer.last_name }
      get "/api/v1/customers/find", params: last_name_params

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)

      expect(raw_customer["id"]).to eq(customer.id)
    end

    it 'sends first customer requested by last_name not matching' do
      last_name_params = { last_name: customer.last_name.upcase }
      get "/api/v1/customers/find", params: last_name_params

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)

      expect(raw_customer["id"]).to eq(customer.id)
      expect(raw_customer["last_name"]).to eq(customer.last_name)
    end

    it 'sends first customer requested by created_at' do
      created_at_params = { created_at: customer.created_at.to_s }

      get '/api/v1/customers/find', params: created_at_params

      raw_customer = JSON.parse(response.body)

      expect(raw_customer["id"]).to eq(customer.id)
    end

    it 'sends first customer requested by updated_at' do
      updated_at_params = { updated_at: customer.updated_at.to_s }

      get '/api/v1/customers/find', params: updated_at_params

      raw_customer = JSON.parse(response.body)

      expect(raw_customer["id"]).to eq(customer.id)
    end
  end

  context 'GET /api/v1/customers/random' do
    it 'sends a random customer' do
      create_list(:customer, 5)
      get '/api/v1/customers/random'

      expect(response).to be_success

      raw_data = JSON>parse(response.body)
      
      expect(raw_data).to have_key("id")
    end
  end
end
