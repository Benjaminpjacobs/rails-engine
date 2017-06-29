class Api::V1::InvoicesController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :invoices, "Invoices Controller"

  swagger_api :index do
    summary "Fetches all invoices"
    notes "This lists all invoices, sortable by record attributes"
    param :query, :customer_id, :integer, :optional, "customer_id"
    param :query, :merchant_id, :integer, :optional, "merchant_id"
    param :query, :id, :integer, :optional, "id"
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  swagger_api :show do
    summary "Fetches single invoice item"
    notes "This returns a single invoice item record by attributes"
    param :query, :id, :integer, :optional, "id"
    param :query, :customer_id, :integer, :optional, "customer_id"
    param :query, :merchant_id, :integer, :optional, "merchant_id"
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  def index
    return render json: Invoice.all if valid_search.empty?
    render json: Invoice.where(valid_search)
  end

  def show
    render json: Invoice.find_by(valid_search)
  end

  private
    def valid_search
      params.permit(:id, :customer_id, :merchant_id).merge(date_search)
    end
end
