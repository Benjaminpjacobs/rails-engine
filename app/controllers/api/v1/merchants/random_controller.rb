class Api::V1::Merchants::RandomController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :merchants_random, 'Merchants Random Controller'
  
  swagger_api :show do
    summary "Fetches random merchant"
  end

  def show
    render json: Merchant.order("RANDOM()").limit(1).first
  end
end