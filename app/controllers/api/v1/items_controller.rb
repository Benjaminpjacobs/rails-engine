class Api::V1::ItemsController < ApplicationController
  
  def index
    return render json: Item.created_at(params[:created_at].to_datetime) if params[:created_at]
    return render json: Item.updated_at(params[:updated_at].to_datetime) if params[:updated_at]
    return render json: Item.all if valid_search.empty?
    render json: Item.where(valid_search)
  end

  def show
    return render json: Item.first_created(params[:created_at].to_datetime) if params[:created_at]
    return render json: Item.first_updated(params[:updated_at].to_datetime) if params[:updated_at]
    render json: Item.find_by(valid_search)
  end

  private

    def valid_search
      date_search = {}
      unit_price = {}
      unit_price[:unit_price] = unit_price_convert if params[:unit_price]
      params.permit(:id, :name, :description, :merchant_id).merge(unit_price)
    end
      
    def unit_price_convert
      (params[:unit_price].to_f * 100).round
    end
  
end
