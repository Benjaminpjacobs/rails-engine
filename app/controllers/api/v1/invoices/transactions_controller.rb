class Api::V1::Invoices::TransactionsController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :invoices, "Invoices Transactions Controller", resource_path: "invoices"

  swagger_api :index do
    summary "Fetches a collection of associated transactions"
    param :query, :id, :integer, :required, "id"

    response :not_found
  end

  def index
    render json: Invoice.find(params[:id]).transactions
  end
end
