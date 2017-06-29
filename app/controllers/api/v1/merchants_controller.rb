class Api::V1::MerchantsController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :merchants, "Merchants"

  swagger_api :index do
    summary "Fetches all merchants"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end

  swagger_api :show do
    summary "Fetches single merchant"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
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
