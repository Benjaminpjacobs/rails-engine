class Api::V1::Transactions::InvoicesController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :transactions, 'Transactions Invoices Controller'
  
  swagger_api :show do
    summary "Fetches invoices for a transaction"
    notes "This returns a single invoice record for a transaction"
    param :query , :id, :integer, :required, "id"
    response :not_found
  end

  def show
    @transactions = Transaction.find(params[:id]).invoice
    return render json: @transactions if @transactions
    not_found
  end
end