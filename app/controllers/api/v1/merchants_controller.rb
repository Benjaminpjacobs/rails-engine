class Api::V1::MerchantsController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :merchants, "Merchants Controller"

  swagger_api :index do
    summary "Fetches all merchants"
    notes "This lists all merchants, sortable by record attributes"
    param :query, :name, :string, :optional, "name" 
    param :query, :id, :integer, :optional, "id"
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  swagger_api :show do
    summary "Fetches single merchant"
    notes "This returns a single merchant record by attributes"
    param :query , :id, :integer, :optional, "id"
    param :query, :name, :string, :optional, "name" 
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  def index
    return render json: Merchant.all if valid_search.empty?
    render json: Merchant.where(valid_search)
  end

  def show
    render json: Merchant.find_by(valid_search)
  end

  private

    def valid_search
      params.permit(:id, :name).merge(date_search)
    end
end
