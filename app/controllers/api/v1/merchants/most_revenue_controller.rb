class Api::V1::Merchants::MostRevenueController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :merchants, 'Merchants Most Revenue Controller', resource_path: "merchants"

  swagger_api :index do
    summary "Fetches the top merchants ranked by total revenue"
    notes "This query can be limited in quantity"
    param :query, :quantity, :integer, :optional, "quantity"
  end

  def index
    return render json: Merchant.by_total_revenue(params[:quantity])
  end
end