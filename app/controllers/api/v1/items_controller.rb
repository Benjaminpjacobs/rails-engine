class Api::V1::ItemsController < ApplicationController
  include UnitPrice
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :items, "Items Controller"

  swagger_api :index do
    summary "Fetches all items"
    notes "This lists all items, sortable by record attributes"
    param :query, :name, :string, :optional, "name"
    param :query, :description, :string, :optional, "description"
    param :query, :merchant_id, :integer, :optional, "merchant_id"
    param :query, :id, :integer, :optional, "id"
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  swagger_api :show do
    summary "Fetches single item"
    notes "This returns a single item record by attributes"
    param :query, :id, :integer, :optional, "id"
    param :query, :name, :string, :optional,  "name"
    param :query, :description, :string, :optional, "description"
    param :query, :merchant_id, :integer, :optional, "merchant_id"
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  def index
    @items = valid_search.empty? ? Item.all : Item.where(valid_search)
    return render json: @items unless @items.empty?
    not_found
  end

  def show
    @items = Item.find_by(valid_search)
    return render json: @items if @items
    not_found
  end

  private

    def valid_search
      params.permit(:id, :name, :description, :merchant_id).merge(unit_price).merge(date_search)
    end
end
