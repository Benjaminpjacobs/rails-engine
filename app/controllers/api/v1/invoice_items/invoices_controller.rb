class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :invoice_items, "Invoice Items Invoices Controller"

  swagger_api :show do
    summary "Fetches the associated invoice"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def show
    render json: InvoiceItem.find(params[:id]).invoice
  end
end
