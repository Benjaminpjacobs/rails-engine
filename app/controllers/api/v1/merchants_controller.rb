class Api::V1::MerchantsController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :merchants, "Merchants"

  swagger_api :index do
    summary "Fetches all merchants"
    notes "This lists all merchants, sortable by record attributes"
    param :query, :find, :string, :optional, "name" 
    param :query, :find, :integer, :optional, "id"
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
  end

  swagger_api :show do
    summary "Fetches single merchant"
    notes "This returns a single merchant record by attributes"
    param :path , :id, :integer, :required, "id"
    param :query, :find, :string, :optional, "name" 
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
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
