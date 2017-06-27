class Api::V1::InvoiceItemsController < ApplicationController
  def index
    return render json: InvoiceItem.where(item_id: params[:item_id]) if params[:item_id]
    return render json: InvoiceItem.where(invoice_id: params[:invoice_id]) if params[:invoice_id]
    return render json: InvoiceItem.where(unit_price: params[:unit_price]) if params[:unit_price]
    return render json: InvoiceItem.where(created_at: params[:created_at].to_datetime.in_time_zone("UTC")) if params[:created_at]
    return render json: InvoiceItem.where(updated_at: params[:updated_at].to_datetime.in_time_zone("UTC")) if params[:updated_at]
    return render json: InvoiceItem.all  
  end

  def show
    return render json: InvoiceItem.find_by(item_id: params[:item_id]) if params[:item_id]
    return render json: InvoiceItem.find_by(invoice_id: params[:invoice_id]) if params[:invoice_id]
    return render json: InvoiceItem.find_by(unit_price: params[:unit_price]) if params[:unit_price]
    return render json: InvoiceItem.find_by(created_at: params[:created_at].to_datetime.in_time_zone("UTC")) if params[:created_at]
    return render json: InvoiceItem.find_by(updated_at: params[:updated_at].to_datetime.in_time_zone("UTC")) if params[:updated_at]
    return render json: InvoiceItem.find(params[:id])
  end
end