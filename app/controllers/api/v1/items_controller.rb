class Api::V1::ItemsController < ApplicationController
  include UnitPrice
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :items, "Items"

  swagger_api :index do
    summary "Fetches all items"
    notes "This lists all items, sortable by record attributes"
    param :query, :find, :string, :optional, "name"
    param :query, :find, :string, :optional, "description"
    param :query, :find, :integer, :optional, "merchant_id"
    param :query, :find, :integer, :optional, "id"
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
  end

  swagger_api :show do
    summary "Fetches single item"
    notes "This returns a single item record by attributes"
    param :path, :id, :integer, :required, "id"
    param :query, :find, :string, :optional,  "name"
    param :query, :find, :string, :optional, "description"
    param :query, :find, :integer, :optional, "merchant_id"
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
  end

  def index
    return render json: Item.all if valid_search.empty?
    render json: Item.where(valid_search)
  end

  def show
    render json: Item.find_by(valid_search)
  end

  private

    def valid_search
      params.permit(:id, :name, :description, :merchant_id).merge(unit_price).merge(date_search)
    end
end
