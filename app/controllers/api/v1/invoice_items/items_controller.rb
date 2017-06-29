class Api::V1::InvoiceItems::ItemsController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :invoice_items, "Invoice Items Items Controller"

  swagger_api :show do
    summary "Fetches item associated with specific invoice item"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def show
    render json: InvoiceItem.find(params[:id]).item
  end
end
