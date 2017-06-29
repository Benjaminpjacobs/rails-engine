class Api::V1::InvoiceItems::RandomController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :invoice_item_random_controller, 'Invoice Item Random Controller'
  
  swagger_api :show do
    summary "Fetches random invoice item"
  end

  def show
    render json: InvoiceItem.order("RANDOM()").limit(1).first
  end
end