class Api::V1::Invoices::MerchantsController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :invoices, "Invoices Merchant Controller"

  swagger_api :show do
    summary "Fetches merchant associated with specific invoice"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def show
    render json: Invoice.find(params[:id]).merchant
  end
end
