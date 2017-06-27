class Api::V1::InvoicesController < ApplicationController
  def index
    return render json: Invoice.where(customer_id: params[:customer_id].to_i) if params[:customer_id]
    return render json: Invoice.where(merchant_id: params[:merchant_id].to_i) if params[:merchant_id]
    return render json: Invoice.where(created_at: params[:created_at].to_datetime.in_time_zone("UTC")) if params[:created_at]
    return render json: Invoice.where(updated_at: params[:updated_at].to_datetime.in_time_zone("UTC")) if params[:updated_at]
    return render json: Invoice.all
  end

  def show
    return render json: Invoice.find_by(customer_id: params[:customer_id]) if params[:customer_id]
    return render json: Invoice.find_by(merchant_id: params[:merchant_id]) if params[:merchant_id]
    return render json: Invoice.find_by(status: params[:status]) if params[:status]
    return render json: Invoice.find_by(created_at: params[:created_at].to_datetime.in_time_zone("UTC")) if params[:created_at]
    return render json: Invoice.find_by(updated_at: params[:updated_at].to_datetime.in_time_zone("UTC")) if params[:updated_at]
    return render json: Invoice.find(params[:id])
  end
end