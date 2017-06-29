class Api::V1::Transactions::RandomController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :transactions_random, 'Transactions Random Controller'
  
  swagger_api :show do
    summary "Fetches random transaction"
  end

  def show
    render json: Transaction.order("RANDOM()").limit(1).first
  end
end