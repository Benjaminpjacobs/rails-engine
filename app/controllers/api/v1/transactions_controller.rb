class Api::V1::TransactionsController < ApplicationController
  def index
    return render json: Transaction.where(id: params["id"]) if params["id"]
    return render json: Transaction.where(invoice_id: params["invoice_id"]) if params["invoice_id"]
    return render json: Transaction.where(credit_card_number: params["credit_card_number"]) if params["credit_card_number"]
    return render json: Transaction.where(result: params["result"]) if params["result"]
    return render json: Transaction.where(created_at: params["created_at"].to_datetime.in_time_zone("UTC")) if params["created_at"]
    return render json: Transaction.where(updated_at: params["updated_at"].to_datetime.in_time_zone("UTC")) if params["updated_at"]
    render json: Transaction.all
  end

  def show
    return render json: Transaction.find_by(id: params["id"]) if params["id"]
    return render json: Transaction.find_by(invoice_id: params["invoice_id"]) if params["invoice_id"]
    return render json: Transaction.find_by(credit_card_number: params["credit_card_number"]) if params["credit_card_number"]
    return render json: Transaction.find_by(result: params["result"]) if params["result"]
    return render json: Transaction.find_by(created_at: params["created_at"].to_datetime.in_time_zone("UTC")) if params["created_at"]
    return render json: Transaction.find_by(updated_at: params["updated_at"].to_datetime.in_time_zone("UTC")) if params["updated_at"]
    render json: Transaction.find(params[:id])
  end
end
