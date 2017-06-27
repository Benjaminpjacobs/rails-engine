class Api::V1::CustomersController < ApplicationController
  def index
    return render json: Customer.where(id: params["id"]) if params["id"]
    return render json: Customer.where(first_name: params["first_name"]) if params["first_name"]
    return render json: Customer.where(last_name: params["last_name"]) if params["last_name"]
    return render json: Customer.where(created_at: params["created_at"].to_datetime.in_time_zone("UTC")) if params["created_at"]
    return render json: Customer.where(updated_at: params["updated_at"].to_datetime.in_time_zone("UTC")) if params["updated_at"]
    render json: Customer.all
  end

  def show
    return render json: Customer.find_by(id: params["id"]) if params["id"]
    return render json: Customer.find_by(first_name: params["first_name"]) if params["first_name"]
    return render json: Customer.find_by(last_name: params["last_name"]) if params["last_name"]
    return render json: Customer.find_by(created_at: params["created_at"].to_datetime.in_time_zone("UTC")) if params["created_at"]
    return render json: Customer.find_by(updated_at: params["updated_at"].to_datetime.in_time_zone("UTC")) if params["updated_at"]
    render json: Customer.find(params[:id])
  end
end
