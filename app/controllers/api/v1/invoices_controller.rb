class Api::V1::InvoicesController < ApplicationController
  include DateSearch

  def index
    return render json: Invoice.all if valid_search.empty?
    render json: Invoice.where(valid_search)
  end

  def show
    render json: Invoice.find_by(valid_search)
  end

  private
    def valid_search
      params.permit(:id, :customer_id, :merchant_id).merge(date_search)
    end
end
