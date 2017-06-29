class Api::V1::Items::MerchantsController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :items, "Items Merchants Controller"

  swagger_api :show do
    summary "Fetches merchant associated with item"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def show
    render json: Item.find(params[:id]).merchant
  end
end
