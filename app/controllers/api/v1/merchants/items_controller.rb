class Api::V1::Merchants::ItemsController < ApplicationController
include Swagger::Docs::Methods

  swagger_controller :merchants, 'Merchants Items Controller', resource_path: "merchants"

  swagger_api :index do
    summary "Fetches a collection of items associated with merchant"
    param :path, :id, :integer, :required, "id"
  end

  def index
    render json: Merchant.find(params[:id]).items
  end
end