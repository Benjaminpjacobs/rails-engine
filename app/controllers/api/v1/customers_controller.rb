class Api::V1::CustomersController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods
  swagger_controller :customers, 'Customers Controller'

  swagger_api :index do
    summary "Get all customers"
    notes "This lists all customers, sortable by record attributes"
    param :query, :first_name, :string, :optional, "first_name"
    param :query, :last_name, :string, :optional, "last_name" 
    param :query, :id, :integer, :optional, "id"
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  swagger_api :show do
    summary "Fetches single customer"
    notes "This returns a single customer record by attributes"
    param :query , :id, :integer, :optional, "id"
    param :query, :first_name, :string, :optional, "first_name"
    param :query, :last_name, :string, :optional, "last_name" 
    param :query, :created_at, :string, :optional, "created_at"
    param :query, :updated_at, :string, :optional, "updated_at"
    response :not_found
  end

  def index
    @customers = valid_search.empty? ? Customer.all : Customer.where(valid_search)
    return render json: @customers unless @customers.empty?
    not_found
  end

  def show
    @customers = Customer.find_by(valid_search)
    return render json: @customers if @customers
    not_found
  end

  private
  
    def valid_search
      params.permit(:id, :first_name, :last_name).merge(date_search)
    end
end
