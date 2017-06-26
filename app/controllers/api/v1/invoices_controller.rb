class Api::V1::InvoicesController < ApplicationController
  def index
    render json: Invoice.all
  end

  def show
    return render json: Invoice.find_by(customer_id: params[:customer_id]) if params[:customer_id]
    return render json: Invoice.find(params[:id])
  end
end