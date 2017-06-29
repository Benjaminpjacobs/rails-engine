class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  include Swagger::Docs::Methods

    swagger_controller :merchants, 'Merchants Favorite Customer Controller', resource_path: "merchants"

  swagger_api :show do
    summary "Fetches the customer who has conducted the most total number of successful transactions."

    param :path, :id, :integer, :required, "id"
  end

  def show
    render json: Merchant.find(params[:id]).favorite_customer
  end 
end