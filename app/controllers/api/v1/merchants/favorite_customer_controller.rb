class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
<<<<<<< HEAD
=======

>>>>>>> 7898306cef579336f95f86e6d35b27e70e05e606
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