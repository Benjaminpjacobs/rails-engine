class Api::V1::Items::MostRevenueController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :items, "Items Most Revenue Controller", resource_path: "items"

  swagger_api :index do
    summary "Fetches the top items ranked by total revenue generated"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def index
    render json: Item.by_most_revenue(params[:quantity])
  end
end