class Api::V1::Merchants::FindMerchantsController < ApplicationController
  def index
    return render json: Merchant.find(params["id"]) if params["id"]
    return render json: Merchant.where(name: params["name"]) if params["name"]
    return render json: Merchant.find_by(created_at: params["created_at"].to_datetime.in_time_zone("UTC")) if params["created_at"]
  end
end
