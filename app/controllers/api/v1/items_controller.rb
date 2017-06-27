class Api::V1::ItemsController < ApplicationController
  
  def index
    return render json: Item.where(id: params[:id]) if params[:id]
    return render json: Item.where(name: params[:name]) if params[:name]
    return render json: Item.where(description: params[:description]) if params[:description]
    return render json: Item.where(unit_price: unit_price) if params[:unit_price]
    return render json: Item.where(merchant_id: params[:merchant_id]) if params[:merchant_id]
    return render json: Item.created_at(params[:created_at].to_datetime) if params[:created_at]
    return render json: Item.updated_at(params[:updated_at].to_datetime) if params[:updated_at]
   return render json: Item.all
  end

  def show
    return render json: Item.find_by(name: params[:name]) if params[:name]
    return render json: Item.find_by(description: params[:description]) if params[:description]
    return render json: Item.find_by(unit_price: unit_price) if params[:unit_price]
    return render json: Item.find_by(merchant_id: params[:merchant_id]) if params[:merchant_id] 
    return render json: Item.first_created(params[:created_at].to_datetime) if params[:created_at]
    return render json: Item.first_updated(params[:updated_at].to_datetime) if params[:updated_at]
    return render json: Item.find(params[:id])
  end
  private

    def unit_price
      (params[:unit_price].to_f * 100).round
    end
  
end