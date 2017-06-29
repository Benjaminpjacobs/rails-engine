class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :invoices, "Invoices Invoice items Controller"

  swagger_api :index do
    summary "Fetches a collection of associated invoice items"
    param :query, :id, :integer, :required, "id"

    response :not_found
  end

  def index
    # render json: InvoiceItem.where(invoice_id: params[:id])
    render json: Invoice.find(params[:id]).invoices
  end
end
