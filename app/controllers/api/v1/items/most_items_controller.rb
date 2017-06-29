class Api::V1::Items::MostItemsController < ApplicationController

  include Swagger::Docs::Methods
  
  swagger_controller :items, "Items Most Items Controller", resource_path: "items"

  swagger_api :index do
    summary "Fetches the top item instances ranked by total number sold"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def index
    render json: Item.most_items(params[:quantity])
  end
end
