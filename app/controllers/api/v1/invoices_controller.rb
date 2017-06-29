class Api::V1::InvoicesController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :invoices, "Invoices"

  swagger_api :index do
    summary "Fetches all invoices"
    notes "This lists all invoices, sortable by record attributes"
    param :query, :find, :integer, :optional, "customer_id"
    param :query, :find, :integer, :optional, "merchant_id"
    param :query, :find, :integer, :optional, "id"
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
  end

  swagger_api :show do
    summary "Fetches single invoice item"
    notes "This returns a single invoice item record by attributes"
    param :path, :id, :integer, :required, "id"
    param :query, :find, :integer, :optional, "customer_id"
    param :query, :find, :integer, :optional, "merchant_id"
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
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
