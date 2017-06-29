class Api::V1::Items::RandomController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :items_random_controller, 'Items Random Controller'
  
  swagger_api :show do
    summary "Fetches random Item"
  end

  def show
    render json: Item.order("RANDOM()").limit(1).first
  end
end
