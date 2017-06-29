require 'rails_helper'

describe "/invoices/:id/association API requests" do
  let(:invoice) { create(:invoice) }

  context "GET /api/v1/invoices/:id/transactions" do
    it "returns a collection of associated transactions" do
      create_list(:transaction, 5, invoice_id: invoice.id)
      
      get "/api/v1/invoices/#{invoice.id}/transactions"

      expect(response).to be_success

      transactions = JSON.parse(response.body)
      transaction = transactions.first

      expect(transactions.count).to eq(5)
      expect(transaction).to have_key("invoice_id")
      expect(transaction["invoice_id"]).to eq(invoice.id)
      expect(transaction).to have_key("credit_card_number")
      expect(transaction).to have_key("result")
    end
  end

  context "GET /api/v1/invoices/:id/invoice_items" do
    it "returns a collection of associated invoice items" do
      create_list(:invoice_item, 5, invoice_id: invoice.id)
      
      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      expect(response).to be_success

      invoice_items = JSON.parse(response.body)
      invoice_item = invoice_items.first

      expect(invoice_items.count).to eq(5)
      expect(invoice_item).to have_key("invoice_id")
      expect(invoice_item["invoice_id"]).to eq(invoice.id)
      expect(invoice_item).to have_key("item_id")
      expect(invoice_item).to have_key("quantity")
      expect(invoice_item).to have_key("unit_price")
    end
  end

  context "GET /api/v1/invoices/:id/items" do
    it "returns a collection of associated items" do
      item1, item2, item3 = create_list(:item, 3)
      invoice.items.append(item1, item2, item3)

      get "/api/v1/invoices/#{invoice.id}/items"

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

  context "GET /api/v1/invoices/:id/customer" do
    it "returns the associated customer" do
      customer = create(:customer)
      invoice1 = create(:invoice, customer_id: customer.id)
      
      get "/api/v1/invoices/#{invoice1.id}/customer"

      expect(response).to be_success

      customer = JSON.parse(response.body)

      expect(customer).to have_key("first_name")
      expect(customer).to have_key("last_name")
    end
  end

  context "GET /api/v1/invoices/:id/merchant" do
    it "returns the associated merchant" do
      merchant = create(:merchant)
      invoice1 = create(:invoice, merchant_id: merchant.id)
      
      get "/api/v1/invoices/#{invoice1.id}/merchant"

      expect(response).to be_success

      merchant = JSON.parse(response.body)

      expect(merchant).to have_key("name")
    end
  end
end
