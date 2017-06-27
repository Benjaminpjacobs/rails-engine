class Api::V1::TransactionsController < ApplicationController
  include DateSearch
  
  def index
    return render json: Transaction.all if valid_search.empty?
    render json: Transaction.where(valid_search)
  end

  def show
    render json: Transaction.find_by(valid_search)
  end

  private

  def valid_search
    params.permit(:id, :invoice_id, :credit_card_number, :result).merge(date_search)
  end

end
