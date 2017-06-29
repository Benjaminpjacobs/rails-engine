class Api::V1::Items::InvoiceItemsController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :items_invoice_items, "Items Invoice Items Controller"

  swagger_api :index do
    summary "Fetches invoice items associated with item"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end
  
  def index
    render json: Item.find(params[:id]).invoice_items
  end
end
