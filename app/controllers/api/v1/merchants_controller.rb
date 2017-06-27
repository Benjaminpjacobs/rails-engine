class Api::V1::MerchantsController < ApplicationController
  include DateSearch
  def index
    return render json: Merchant.all if valid_search.empty?
    render json: Merchant.where(valid_search)
  end

  def show
    render json: Merchant.find_by(valid_search)
  end

  private

    def valid_search
      params.permit(:id, :name).merge(date_search)
    end
end
