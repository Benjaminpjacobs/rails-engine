class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  include Swagger::Docs::Methods

    swagger_controller :merchants_favorite, 'Merchants Favorite Customer Controller'

  swagger_api :show do
    summary "Fetches the favorite customer"
    notes "This returns a single customer based on most successful transactions with given merchant"

    param :path, :id, :integer, :required, "id"
  end

  def show
    render json: Merchant.find(params[:id]).favorite_customer
  end 
end