class Api::V1::TransactionsController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :transactions, "Transactions Controller"

  swagger_api :index do
    summary "Fetches all transactions"
    notes "This lists all transactions, sortable by record attributes"
    param :query, :invoice_id, :integer, :optional, "invoice_id"
    param :query, :credit_card_number, :string, :optional, "credit_card_number"
    param :query, :result, :string, :optional, "result"
    param :query, :id, :integer, :optional, "id"
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  swagger_api :show do
    summary "Fetches single transaction"
    notes "This returns a single transaction record by attributes"
    param :query, :id, :integer, :optional, "id"
    param :query, :invoice_id, :integer, :optional, "invoice_id"
    param :query, :credit_card_number, :string, :optional, "credit_card_number"
    param :query, :result, :string, :optional, "result"
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  def index
    return render json: Transaction.all if valid_search.empty?
    render json: Transaction.where(valid_search)
  end

  def show

    render json: Transaction.find_by(valid_search)
  end

  private

  def valid_search
    params.permit(:id, :invoice_id, :credit_card_number, :result).merge(date_search)
  end

end
