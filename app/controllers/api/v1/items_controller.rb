class Api::V1::ItemsController < ApplicationController
  include UnitPrice

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
      params.permit(:id, :name, :description, :merchant_id).merge(unit_price)
    end
end
