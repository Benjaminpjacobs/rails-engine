class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    return render json: Invoice.total_revenue(params[:date].to_datetime) if params[:date]
  end

  def show
    return render json: Merchant.find(params[:id]).revenue(params[:date]) if params[:date]
    render json: Merchant.find(params[:id]).revenue
  end
end
