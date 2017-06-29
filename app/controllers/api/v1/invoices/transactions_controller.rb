class Api::V1::Invoices::TransactionsController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :invoices, "Invoices Transactions Controller"

  swagger_api :index do
    summary "Fetches transactions associated with specific invoice"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def index
    render json: Invoice.find(params[:id]).transactions
  end
end
