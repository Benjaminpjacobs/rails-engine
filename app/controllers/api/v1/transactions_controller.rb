class Api::V1::TransactionsController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :transactions, "Transactions"

  swagger_api :index do
    summary "Fetches all transactions"
    notes "This lists all transactions, sortable by record attributes"
    param :query, :find, :integer, :optional, "invoice_id"
    param :query, :find, :string, :optional, "credit_card_number"
    param :query, :find, :string, :optional, "result"
    param :query, :find, :integer, :optional, "id"
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
  end

  swagger_api :show do
    summary "Fetches single transaction"
    notes "This returns a single transaction record by attributes"
    param :path, :id, :integer, :required, "id"
    param :query, :find, :integer, :optional, "invoice_id"
    param :query, :find, :string, :optional, "credit_card_number"
    param :query, :find, :string, :optional, "result"
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
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
