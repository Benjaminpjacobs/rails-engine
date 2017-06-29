class Api::V1::Customers::RandomController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :customer_random_controller, 'Customer Random Controller'
  
  swagger_api :show do
    summary "Fetches random customer"
  end

  def show
    render json: InvoiceCustomerItem.order("RANDOM()").limit(1).first
  end
end