class Api::V1::Invoices::MerchantsController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :invoices, "Invoices Merchant Controller", resource_path: "invoices"

  swagger_api :show do
    summary "Fetches the associated merchant"
    param :query, :id, :integer, :required, "id"

    response :not_found
  end

  def show
    render json: Invoice.find(params[:id]).merchant
  end
end
