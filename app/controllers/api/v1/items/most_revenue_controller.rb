class Api::V1::Items::MostRevenueController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :items, "Items Most Revenue Controller"

  swagger_api :index do
    summary "Fetches items ranked by most revenue generated"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def index
    render json: Item.most_revenue(params[:quantity])
  end
end