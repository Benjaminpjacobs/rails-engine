class Api::V1::Invoices::RandomController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :invoices_random_controller, 'Invoices Random Controller'
  
  swagger_api :show do
    summary "Fetches random Invoice"
  end

  def show
    render json: Invoice.order("RANDOM()").limit(1).first
  end
end