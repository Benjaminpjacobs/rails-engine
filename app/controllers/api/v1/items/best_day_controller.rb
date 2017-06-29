class Api::V1::Items::BestDayController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :items, "Items Best Day Controller"

  swagger_api :show do
    summary "Fetches the date with the most sales for the given item using the invoice date."
    notes "If there are multiple days with equal number of sales, return the most recent day."
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def show
    render json: Item.find(params[:id]).best_day, serializer: BestDaySerializer
  end
end
