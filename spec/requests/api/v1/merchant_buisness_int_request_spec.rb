require 'rails_helper'

describe 'Merchant Business Intelligence Endpoints' do
  context 'All Merchants' do
    context 'GET /api/v1/merchants/most_items?quantity=x' do
      it 'returns the top x merchants ranked by total number of items sold' do
        merchant1, merchant2, merchant3 = create_list(:merchant, 3)
        item1 = create(:item, merchant_id: merchant1.id)
        item2 = create(:item, merchant_id: merchant3.id)
        item3 = create(:item, merchant_id: merchant2.id)
        invoice1 = create(:invoice, merchant_id: merchant1.id)
        invoice2 = create(:invoice, merchant_id: merchant2.id)
        invoice3 = create(:invoice, merchant_id: merchant3.id)
        create(:invoice_item, item_id: item1.id, quantity: 5, invoice_id: invoice1.id)
        create(:invoice_item, item_id: item2.id, quantity: 10, invoice_id: invoice2.id)
        create(:invoice_item, item_id: item3.id, quantity: 15, invoice_id: invoice3.id)
        create(:transaction, invoice_id: invoice1.id)
        create(:transaction, invoice_id: invoice2.id)
        create(:transaction, invoice_id: invoice3.id)

        get "/api/v1/merchants/most_items?quantity=2"

        expect(response).to be_success

        merchants = JSON.parse(response.body)
        expect(merchants.count).to eq(2)
        
        expect(merchants.first["id"]).to eq(merchant3.id)
        expect(merchants.last["id"]).to eq(merchant2.id)
      end
    end

    context "GET /api/v1/merchants/revenue?date=x" do
      it 'sends total merchant revenue on date' do
        date = "2012-03-16 11:55:05"
        merchant = create(:merchant)
        customer = create(:customer)
        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: date.to_datetime)
        create(:invoice_item, invoice_id: invoice.id, unit_price: 1025, quantity: 5)

        get "/api/v1/merchants/revenue?date=#{date}"

        expect(response).to be_success
        
        revenue = JSON.parse(response.body)

        expect(revenue).to eq({"total_revenue" => "51.25"})
      end
    end
  end

  context 'Single Merchant' do
    context 'GET /api/v1/merchants/:id/revenue' do
      it 'returns the total revenue for that merchant across all transactions' do
        merchant = create(:merchant)
        customer = create(:customer)
        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
        create(:transaction, invoice_id: invoice.id)
        create(:invoice_item, invoice_id: invoice.id, unit_price: 1025, quantity: 5)

        get "/api/v1/merchants/#{merchant.id}/revenue"

        revenue = JSON.parse(response.body)

        expect(revenue["revenue"]).to eq("51.25")
      end
    end

    context 'GET /api/v1/merchants/:id/revenue?date=x' do
      it 'returns the total revenue for that merchant for a specific invoice date x' do
        date = "2012-03-16 11:55:05"
        merchant = create(:merchant)
        customer = create(:customer)
        invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: date)
        create(:transaction, invoice_id: invoice.id)
        create(:invoice_item, invoice_id: invoice.id, unit_price: 1025, quantity: 10)
        get "/api/v1/merchants/#{merchant.id}/revenue?date=#{date}"

        revenue = JSON.parse(response.body)

        expect(revenue["revenue"]).to eq("102.5")
      end
    end

    context 'GET /api/v1/merchants/:id/favorite_customer' do
      it 'returns the customer who has conducted the most total number of successful transactions' do
      merchant = create(:merchant)
      customer1, customer2 = create_list(:customer, 2)
      invoice1 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
      invoice2 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
      invoice3 = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
      invoice4 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
      invoice5 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
      invoice6 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
      create(:transaction, invoice_id: invoice1.id, result: "success")
      create(:transaction, invoice_id: invoice2.id, result: "success")
      create(:transaction, invoice_id: invoice3.id, result: "failed")
      create(:transaction, invoice_id: invoice4.id, result: "success")
      create(:transaction, invoice_id: invoice5.id, result: "success")
      create(:transaction, invoice_id: invoice6.id, result: "success")
      

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      expect(response).to be_success

      customer = JSON.parse(response.body)

      expect(customer["id"]).to eq(customer2.id)
      end
    end
  end
end
