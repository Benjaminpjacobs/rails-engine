class Api::V1::MerchantsController < ApplicationController
  def index
    return render json: Merchant.all if valid_search.empty?
    render json: Merchant.where(valid_search)
  end

  def show
    render json: Merchant.find_by(valid_search)
  end

  private

    def valid_search
      date_search = {}
      date_search[:created_at]= params["created_at"].to_datetime.in_time_zone("UTC") if params["created_at"]
      date_search[:updated_at]= params["updated_at"].to_datetime.in_time_zone("UTC") if params["updated_at"]
      params.permit(:id, :name).merge(date_search)
    end
end
