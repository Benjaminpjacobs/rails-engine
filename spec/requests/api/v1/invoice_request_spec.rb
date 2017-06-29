require 'rails_helper'

describe "Invoice API" do
  context 'GET /api/v1/invoices' do
    it "sends a list of invoices" do
      create_list(:invoice, 3)

      get '/api/v1/invoices'

      expect(response).to be_success

      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(invoices.count).to eq(3)
      expect(invoice).to have_key("customer_id")
      expect(invoice).to have_key("merchant_id")
      expect(invoice).to have_key("status")
    end
  end

  context 'GET /api/v1/invoices/:id' do
    it "sends a single invoice" do
      invoice = create(:invoice)

      get "/api/v1/invoices/#{invoice.id}"

      expect(response).to be_success

      invoice_response = JSON.parse(response.body)
      expect(invoice_response["customer_id"]).to eq(invoice.customer_id)
      expect(invoice_response["merchant_id"]).to eq(invoice.merchant_id)
      expect(invoice_response["status"]).to eq(invoice.status)
    end
  end

  context 'GET /api/v1/invoices/find?params' do
    j
    let(:date) { "2017-06-26 22:58:34 UTC" }
    let(:invoice1) { create(:invoice, created_at: date, updated_at: date) }
    let(:date2) { "2017-07-26 22:58:34 UTC" }
    let(:invoice2) { create(:invoice, created_at: date2, updated_at: date2) }
    
    it "finds a single invoice based on customer id" do
      get "/api/v1/invoices/find?customer_id=#{invoice1.customer.id}"
      expect(response).to be_success
      invoice_response = JSON.parse(response.body)
      expect(invoice_response["id"]).to eq(invoice1.id)
    end


    it 'finds a single invoice based on merchant id' do
      get "/api/v1/invoices/find?merchant_id=#{invoice2.merchant_id}"
      expect(response).to be_success
      invoice_response = JSON.parse(response.body)
      expect(invoice_response["id"]).to eq(invoice2.id)
    end

    it 'finds a single invoice based on invoice status case matching' do
      get "/api/v1/invoices/find?status=#{invoice1.status}"
      expect(response).to be_success
      invoice_response = JSON.parse(response.body)
      expect(invoice_response["id"]).to eq(invoice1.id)
    end

    it 'finds a single invoice based on invoice status case insensitive' do
      get "/api/v1/invoices/find?status=#{invoice1.status.upcase}"
      expect(response).to be_success
      invoice_response = JSON.parse(response.body)
      expect(invoice_response["id"]).to eq(invoice1.id)
    end
      
    it 'finds a single invoice based on created at date' do
      get "/api/v1/invoices/find?created_at=#{invoice2.created_at.to_s}"
      expect(response).to be_success
      invoice_response = JSON.parse(response.body)
      expect(invoice_response["id"]).to eq(invoice2.id)
    end
      
    it 'finds a single invoice based on updated at date' do
      get "/api/v1/invoices/find?updated_at=#{invoice1.updated_at.to_s}"
      expect(response).to be_success
      invoice_response = JSON.parse(response.body)
      expect(invoice_response["id"]).to eq(invoice1.id)
    end
  end
    
  context 'GET /api/v1/invoices/find_all?params' do
    it "finds all invoices based on customer id" do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      customer1, customer2 = create_list(:customer, 2)

      invoice1, invoice2 = create_list(:invoice, 2, merchant_id: merchant1.id, customer_id: customer1.id, created_at: date, updated_at: date)

      invoice3, invoice4 = create_list(:invoice, 2, merchant_id: merchant2.id, customer_id: customer2.id, created_at: date2, updated_at: date2)
      get "/api/v1/invoices/find_all?customer_id=#{customer1.id}"
      expect(response).to be_success
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
      expect(invoice_response.first["id"]).to eq(invoice1.id)
      expect(invoice_response.last["id"]).to eq(invoice2.id)
    end

    it 'finds all invoices based on merchant id' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      customer1, customer2 = create_list(:customer, 2)

      invoice1, invoice2 = create_list(:invoice, 2, merchant_id: merchant1.id, customer_id: customer1.id, created_at: date, updated_at: date)

      invoice3, invoice4 = create_list(:invoice, 2, merchant_id: merchant2.id, customer_id: customer2.id, created_at: date2, updated_at: date2)
      get "/api/v1/invoices/find_all?merchant_id=#{merchant2.id}"
      expect(response).to be_success
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
      expect(invoice_response.first["id"]).to eq(invoice3.id)
      expect(invoice_response.last["id"]).to eq(invoice4.id)
    end

    it 'finds all invoices based on created at date' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      customer1, customer2 = create_list(:customer, 2)

      invoice1, invoice2 = create_list(:invoice, 2, merchant_id: merchant1.id, customer_id: customer1.id, created_at: date, updated_at: date)

      invoice3, invoice4 = create_list(:invoice, 2, merchant_id: merchant2.id, customer_id: customer2.id, created_at: date2, updated_at: date2)
      get "/api/v1/invoices/find_all?created_at=#{date.to_s}"
      expect(response).to be_success
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
      expect(invoice_response.first["id"]).to eq(invoice1.id)
      expect(invoice_response.last["id"]).to eq(invoice2.id)
    end

    it 'finds all invoices based on updated at date' do
      date = "2017-06-26 22:58:34 UTC"
      date2 = "2017-07-26 22:58:34 UTC"

      merchant1, merchant2 = create_list(:merchant, 2)
      customer1, customer2 = create_list(:customer, 2)

      invoice1, invoice2 = create_list(:invoice, 2, merchant_id: merchant1.id, customer_id: customer1.id, created_at: date, updated_at: date)

      invoice3, invoice4 = create_list(:invoice, 2, merchant_id: merchant2.id, customer_id: customer2.id, created_at: date2, updated_at: date2)
      get "/api/v1/invoices/find_all?updated_at=#{date2.to_s}"
      expect(response).to be_success
      invoice_response = JSON.parse(response.body)
      expect(invoice_response.count).to eq(2)
      expect(invoice_response.first["id"]).to eq(invoice3.id)
      expect(invoice_response.last["id"]).to eq(invoice4.id)
    end
  end

  context 'get /api/v1/invoices/random' do
    it 'sends a random invoice' do
      create_list(:invoice, 5)
      get '/api/v1/invoices/random'

      expect(response).to be_success

      raw_data = JSON.parse(response.body)
      
      expect(raw_data).to have_key("id")
    end
  end
end
