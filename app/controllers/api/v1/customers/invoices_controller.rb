class Api::V1::Customers::InvoicesController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :customers, "Customers Invoices Controller"

  swagger_api :index do
    summary "Fetches invoices associated with specific customer"
    param :query, :id, :integer, :optional, "id"
    response :not_found
  end

  def index
    render json: Customer.find(params[:id]).invoices
  end
end