class Api::V1::CustomersController < ApplicationController
  include DateSearch

  def index
    return render json: Customer.all if valid_search.empty?
    render json: Customer.where(valid_search)
  end

  def show
    render json: Customer.find_by(valid_search)
  end

  private
  
    def valid_search
      params.permit(:id, :first_name, :last_name).merge(date_search)
    end
end
