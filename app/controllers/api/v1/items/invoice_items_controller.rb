class Api::V1::Items::InvoiceItemsController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :items, "Items Invoice Items Controller", resource_path: "items"

  swagger_api :index do
    summary "Fetches a collection of associated invoice items"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end
  
  def index
    render json: Item.find(params[:id]).invoice_items
  end
end
