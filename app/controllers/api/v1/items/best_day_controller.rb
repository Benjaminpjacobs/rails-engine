class Api::V1::Items::BestDayController < ApplicationController
<<<<<<< HEAD
  include Swagger::Docs::Methods
  
=======
>>>>>>> 7898306cef579336f95f86e6d35b27e70e05e606
  swagger_controller :items_best_day, "Items Best Day Controller"

  swagger_api :show do
    summary "Fetches the date of the item's best sale day"
    param :query, :id, :integer, :optional, "id"

    response :not_found
  end

  def show
    render json: Item.find(params[:id]).best_day, serializer: BestDaySerializer
  end
end
