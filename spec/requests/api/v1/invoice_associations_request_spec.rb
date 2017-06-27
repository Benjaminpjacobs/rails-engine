require 'rails_helper'

describe "invoices/:id/association API requests" do
  let(:invoice) { create(:invoice) }

  context "GET /api/v1/invoices/:id/items" do
    it "sends a list of items for requested invoice" do
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

  context "GET api/v1/invoices/:id/transactions" do
    it "sends a list of transactions for requested invoice" do
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
end
