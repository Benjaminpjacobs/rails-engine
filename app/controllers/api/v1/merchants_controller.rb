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
    @merchants = valid_search.empty? ? Merchant.all : Merchant.where(valid_search)
    return render json: @merchants unless @merchants.empty?
  end

  def show
    @merchants = Merchant.find_by(valid_search)
    return render json: @merchants if @merchants
    not_found
  end

  private

    def valid_search
      params.permit(:id, :name).merge(date_search)
    end
end
