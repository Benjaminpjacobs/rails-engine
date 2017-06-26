require 'rails_helper'

describe "Invoice API request" do
  it "sends a list of invoices " do
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

  it "sends a single invoices " do
    invoice = create(:invoice)

    get "/api/v1/invoice/#{invoice.id}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice["customer_id"]).to have_key(invoice.customer_id)
    expect(invoice["merchant_id"]).to have_key(invoice.merchant_id)
    expect(invoice["status"]).to have_key(invoice.status)
  end
  

end
