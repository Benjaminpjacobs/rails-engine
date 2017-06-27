class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    return render json: Invoice.total_revenue(params[:date].to_datetime) if params[:date]
  end
end