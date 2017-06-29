class Api::V1::CustomersController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :customers, "Customers"

  swagger_api :index do
    summary "Fetches all customers"
    notes "This lists all customers, sortable by record attributes"
    param :query, :find, :string, :optional, "first_name"
    param :query, :find, :string, :optional, "last_name" 
    param :query, :find, :integer, :optional, "id"
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
  end

  swagger_api :show do
    summary "Fetches single customer"
    notes "This returns a single customer record by attributes"
    param :path , :id, :integer, :required, "id"
    param :query, :find, :string, :optional, "first_name"
    param :query, :find, :string, :optional, "last_name" 
    param :query, :find, :datetime, :optional, "created_at"
    param :query, :find, :datetime, :optional, "updated_at"
    response :not_found
    response :not_acceptable
  end

  def index
    return render json: Customer.all if valid_search.empty?
    render json: Customer.where(valid_search)
  end

  def show
    render json: Customer.find_by(valid_search)
  end

  private
  
    def valid_search
      params.permit(:id, :first_name, :last_name).merge(date_search)
    end
end
