class Api::V1::ItemsController < ApplicationController
  
  def index
    return render json: Item.where(name: params[:name]) if params[:name]
    return render json: Item.where(description: params[:description]) if params[:description]
    return render json: Item.where(unit_price: params[:unit_price]) if params[:unit_price]
    return render json: Item.where(merchant_id: params[:merchant_id]) if params[:merchant_id]
    return render json: Item.where(created_at: params[:created_at].to_datetime.in_time_zone("UTC")) if params[:created_at]
    return render json: Item.where(updated_at: params[:updated_at].to_datetime.in_time_zone("UTC")) if params[:updated_at]
   return render json: Item.all
  end

  def show
    return render json: Item.find_by(name: params[:name]) if params[:name]
    return render json: Item.find_by(description: params[:description]) if params[:description]
    return render json: Item.find_by(unit_price: params[:unit_price]) if params[:unit_price]
    return render json: Item.find_by(merchant_id: params[:merchant_id]) if params[:merchant_id]
    return render json: Item.find_by(created_at: params[:created_at].to_datetime.in_time_zone("UTC")) if params[:created_at]
    return render json: Item.find_by(updated_at: params[:updated_at].to_datetime.in_time_zone("UTC")) if params[:updated_at]
    return render json: Item.find(params[:id])
  end
end