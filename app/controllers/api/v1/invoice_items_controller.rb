class Api::V1::InvoiceItemsController < ApplicationController
  include DateSearch
  include UnitPrice
  include Swagger::Docs::Methods

  swagger_controller :invoice_items, "Invoice items"

  swagger_api :index do
    summary "Fetches all invoice items"
    notes "This lists all invoice items, sortable by record attributes"
    param :query, :find, :integer, :optional, "item_id"
    param :query, :find, :integer, :optional, "invoice_id"
    param :query, :find, :integer, :optional, "quantity" 
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
    param :query, :find, :integer, :optional, "item_id"
    param :query, :find, :integer, :optional, "invoice_id"
    param :query, :find, :integer, :optional, "quantity" 
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
  end

  def index
    return render json: InvoiceItem.all if valid_search.empty?
    render json: InvoiceItem.where(valid_search)
  end

  def show
    render json: InvoiceItem.find_by(valid_search)
  end
  
  private

    def valid_search
      params.permit(:id, :item_id, :invoice_id, :quantity).merge(date_search).merge(unit_price)
    end
      
end
