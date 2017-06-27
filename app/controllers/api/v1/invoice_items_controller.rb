class Api::V1::InvoiceItemsController < ApplicationController
  include DateSearch
  include UnitPrice
  def index
    return render json: InvoiceItem.all if valid_search.empty?
    render json: InvoiceItem.where(valid_search)
  end

  def show
    render json: InvoiceItem.find_by(valid_search)
  end
  
  private

    def valid_search
      params.permit(:id, :item_id, :invoice_id, :quantity).merge(date_search).merge(unit_price)
    end
      
end
