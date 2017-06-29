class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :merchants, 'Merchants Customers With Pending Invoices Controller'

  swagger_api :index do
    summary "Fetches customers with pending invoices"
    notes "This returns a list of customers with invoices that have no successful transactions"

    param :path, :id, :integer, :required, "id"
  end

  def index
    render json: Customer.pending_invoices(params[:id])
  end
end