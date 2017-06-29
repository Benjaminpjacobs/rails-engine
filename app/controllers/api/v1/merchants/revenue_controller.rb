class Api::V1::Merchants::RevenueController < ApplicationController
  include DateSearch

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
