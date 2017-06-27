class Api::V1::InvoiceItemsController < ApplicationController
  def index
    return render json: InvoiceItem.all if valid_search.empty?
    render json: InvoiceItem.where(valid_search)
  end

  def show
    render json: InvoiceItem.find_by(valid_search)
  end
  
  private

    def valid_search
      date_search = {}
      date_search[:created_at] = params["created_at"].to_datetime.in_time_zone("UTC") if params["created_at"]
      date_search[:updated_at] = params["updated_at"].to_datetime.in_time_zone("UTC") if params["updated_at"]
      unit_price = {}
      unit_price[:unit_price] = unit_price_convert if params[:unit_price]
      params.permit(:id, :item_id, :invoice_id, :quantity).merge(date_search).merge(unit_price)
    end
      
    def unit_price_convert
      (params[:unit_price].to_f * 100).round
    end
end
