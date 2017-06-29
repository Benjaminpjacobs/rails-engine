class Api::V1::Transactions::InvoicesController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :transactions, 'Transactions Invoices Controller', resource_path: "transactions"
  
  swagger_api :show do
    summary "Fetches the associated invoice"
    param :query , :id, :integer, :required, "id"
    response :not_found
  end

  def show
    @transactions = Transaction.find(params[:id]).invoice
    return render json: @transactions if @transactions
    not_found
  end
end