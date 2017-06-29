class Api::V1::InvoiceItemsController < ApplicationController
  include DateSearch
  include UnitPrice
  include Swagger::Docs::Methods

  swagger_controller :invoice_items, "Invoice Items Controller"

  swagger_api :index do
    summary "Fetches all invoice items"
    notes "This lists all invoice items, sortable by record attributes"
    param :query, :item_id, :integer, :optional, "item_id"
    param :query, :invoice_id, :integer, :optional, "invoice_id"
    param :query, :quantity, :integer, :optional, "quantity" 
    param :query, :id, :integer, :optional, "id"
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  swagger_api :show do
    summary "Fetches single invoice item"
    notes "This returns a single invoice item record by attributes"
    param :query, :id, :integer, :optional, "id"
    param :query, :item_id, :integer, :optional, "item_id"
    param :query, :invoice_id, :integer, :optional, "invoice_id"
    param :query, :quantity, :integer, :optional, "quantity" 
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  def index
    @invoice_items = valid_search.empty? ? InvoiceItem.all : InvoiceItem.where(valid_search)
    return render json: @invoice_items unless @invoice_items.empty?
    not_found
  end

  def show
    @invoice_items = InvoiceItem.find_by(valid_search)
    return render json: @invoice_items if @invoice_items
    not_found
  end
  
  private

    def valid_search
      params.permit(:id, :item_id, :invoice_id, :quantity).merge(date_search).merge(unit_price)
    end
      
end
