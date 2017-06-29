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
    @invoices = valid_search.empty? ? Invoice.all : Invoice.where(valid_search)
    return render json: @invoices unless @invoices.empty?
    not_found
  end

  def show
    @invoices = Invoice.find_by(valid_search)
    return render json: @invoices if @invoices
    not_found
  end

  private
    def valid_search
      params.permit(:id, :customer_id, :merchant_id).merge(date_search)
    end
end
