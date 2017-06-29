class Api::V1::Merchants::RevenueController < ApplicationController
  include DateSearch
  include Swagger::Docs::Methods

  swagger_controller :merchants, 'Merchants Revenue Controller'

  swagger_api :index do
    summary "Fetches total revenue across merchants"
    notes "This returns a single value for total revenue, can be scoped to a date"
    param :query, :date, :string, :optional, "date"
  end

  swagger_api :show do
    summary "Fetches total revenue across merchants"
    notes "This returns a single value for total revenue, can be scoped to a date"
    param :path, :id, :integer, :required, "id"
    param :query, :date, :string, :optional, "date"
  end


  def index
    return render json: Invoice.total_revenue(valid_date), serializer: TotalRevenueSerializer
  end
  
  def show
    return render json: Merchant.find(params[:id]).revenue(valid_date), serializer: RevenueSerializer 
  end

  private 

    def valid_date
      params[:date].to_datetime if params[:date]
    end
end
