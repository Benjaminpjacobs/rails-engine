class Api::V1::InvoicesController < ApplicationController
  def index
    return render json: Invoice.all if valid_search.empty?
    render json: Invoice.where(valid_search)
  end

  def show
    render json: Invoice.find_by(valid_search)
  end

  private
    def valid_search
      date_search = {}
      date_search[:created_at] = params[:created_at].to_datetime.in_time_zone("UTC") if params[:created_at]
      date_search[:updated_at] = params[:updated_at].to_datetime.in_time_zone("UTC") if params[:updated_at]
      params.permit(:id, :customer_id, :merchant_id).merge(date_search)
    end
end
