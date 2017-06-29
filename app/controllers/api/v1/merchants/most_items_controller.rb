class Api::V1::Merchants::MostItemsController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :merchants, 'Merchants Most Items Controller', resource_path: "merchants"

  swagger_api :index do
    summary "Fetches the top merchants ranked by total number of items sold"
    notes "This query can be limited in quantity"
    param :query, :quantity, :integer, :optional, "quantity"
  end

  def index
    return render json: Merchant.most_items(params[:quantity])
  end
end
