class Api::V1::Customers::TransactionsController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :customers, "Customers Transactions Controller", resource_path: "customers"

  swagger_api :index do
    summary "Fetches a collection of associated transactions"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def index
    render json: Customer.find(params[:id]).transactions
  end
end