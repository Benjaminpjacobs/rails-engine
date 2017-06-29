class Api::V1::Invoices::CustomersController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :invoices, "Invoices Customer Controller"

  swagger_api :show do
    summary "Fetches the associated customer"
    param :query, :id, :integer, :required, "id"

    response :not_found
  end

  def show
    render json: Invoice.find(params[:id]).customer
  end
end
