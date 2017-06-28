class Api::V1::Merchants::RevenueController < ApplicationController
  include DateSearch
  def index
    return render json: Invoice.total_revenue(valid_date) if valid_date
  end

  private 

    def valid_date
      params[:date].to_datetime
    end
end