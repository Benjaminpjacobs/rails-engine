class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  include Swagger::Docs::Methods
  
  swagger_controller :customers, "Customers Favorite Merchant Controller"

  swagger_api :show do
    summary "Fetches favorite merchant of specific customer"
    notes "Returns the merchant with whom the specific customer has completed the most successful transactions"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def show
    render json: Customer.find(params[:id]).favorite_merchant
  end
end
