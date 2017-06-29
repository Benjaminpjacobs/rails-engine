class Api::V1::ItemsController < ApplicationController
  include UnitPrice
  include DateSearch

  def index
    return render json: Item.all if valid_search.empty?
    render json: Item.where(valid_search)
  end

  def show
    render json: Item.find_by(valid_search)
  end

  private

    def valid_search
      params.permit(:id, :name, :description, :merchant_id).merge(unit_price).merge(date_search)
    end
end
