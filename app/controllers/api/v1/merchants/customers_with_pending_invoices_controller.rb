class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :merchants, 'Merchants Customers With Pending Invoices Controller', resource_path: "merchants"

  swagger_api :index do
    summary "Fetches customers with pending invoices"
    notes "Returns a collection of customers which have unpaid invoices. An unpaid invoice has no transactions with a result of success."

    param :path, :id, :integer, :required, "id"
  end

  def index
    render json: Customer.pending_invoices(params[:id])
  end
end