class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :invoices, "Invoices Invoice items Controller"

  swagger_api :index do
    summary "Fetches invoice items associated with specific invoice"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def index
    render json: InvoiceItem.where(invoice_id: params[:id])
  end
end
