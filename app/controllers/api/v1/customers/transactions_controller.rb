class Api::V1::Customers::TransactionsController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :customers_transactions, "Customers Transactions Controller"

  swagger_api :index do
    summary "Fetches transactions associated with specific customer"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def index
    render json: Customer.find(params[:id]).transactions
  end
end