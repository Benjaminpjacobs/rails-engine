class Api::V1::CustomersController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :customers, "Customers"

  swagger_api :index do
    summary "Fetches all customers"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end

  swagger_api :show do
    summary "Fetches single customer"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
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
