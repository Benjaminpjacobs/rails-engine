class Api::V1::Merchants::MostItemsController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :merchants, 'Merchants Most Items Controller'

  swagger_api :index do
    summary "Fetches merchants ranked by most items sold"
    notes "This returns the merchants listed by total items sold, can be limited in quantity"
    param :query, :quantity, :integer, :optional, "quantity"
  end

  def index
    return render json: Merchant.most_items(params[:quantity])
  end
end
