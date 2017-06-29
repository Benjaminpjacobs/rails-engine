require 'rails_helper'

describe "InvoiceItems Relationship Endpoints" do

  context "GET /api/v1/invoice_items/:id/invoice" do
    it "sends the invoice for requested invoice_item" do
      invoice = create(:invoice)
      invoice_item = create(:invoice_item, invoice_id: invoice.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      expect(response).to be_success
      invoice = JSON.parse(response.body)

      expect(invoice).to have_key("customer_id")
      expect(invoice).to have_key("merchant_id")
      expect(invoice).to have_key("status")
    end
  end

  context "GET /api/v1/invoice_items/:id/item" do
    it "sends the item for requested invoice_item" do
      item = create(:item)
      invoice_item = create(:invoice_item, item_id: item.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      expect(response).to be_success
      item = JSON.parse(response.body)

      expect(item).to have_key("name")
      expect(item).to have_key("description")
    end
  end
end
