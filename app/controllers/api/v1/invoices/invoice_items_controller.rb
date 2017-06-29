class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :invoices, "Invoices Invoice items Controller", resource_path: "invoices"

  swagger_api :index do
    summary "Fetches a collection of associated invoice items"
    param :query, :id, :integer, :required, "id"

    response :not_found
  end

  def index
    render json: Invoice.find(params[:id]).invoice_items
  end
end
