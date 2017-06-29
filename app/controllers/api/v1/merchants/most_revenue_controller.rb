class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    return render json: Merchant.total_revenue(params[:quantity])
  end
end