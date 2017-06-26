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

    get "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_success

    invoice_response = JSON.parse(response.body)
    expect(invoice_response["customer_id"]).to eq(invoice.customer_id)
    expect(invoice_response["merchant_id"]).to eq(invoice.merchant_id)
    expect(invoice_response["status"]).to eq(invoice.status)
  end

  it "finds based on a single parameter " do
    invoice1, invoice2 = create_list(:invoice, 2)

    get "/api/v1/invoices/find?customer_id=#{invoice1.customer.id}"
    expect(response).to be_success
    invoice_response = JSON.parse(response.body)
    expect(invoice_response["id"]).to eq(invoice1.id)

  end
  

end
