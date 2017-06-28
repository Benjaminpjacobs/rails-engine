class Api::V1::Merchants::RevenueController < ApplicationController
  include DateSearch

  def index
    return render json: Invoice.calculate_revenue_by(valid_date), serializer: TotalRevenueSerializer
  end
  
  def show
    return render json: Merchant.find(params[:id]).revenue(params[:date]), serializer: RevenueSerializer if params[:date]
    render json: Merchant.find(params[:id]).revenue, serializer: RevenueSerializer
  end

  private 

    def valid_date
      params[:date].to_datetime
    end
end
