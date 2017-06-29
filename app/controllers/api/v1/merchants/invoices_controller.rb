class Api::V1::Merchants::InvoicesController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :merchants, 'Merchants Invoices Controller', resource_path: "merchants"

  swagger_api :index do
    summary "Fetches a collection of Invoices associated with merchant"
    notes "Returns a collection of invoices associated with that merchant from their known orders"
    param :path, :id, :integer, :required, "id"
  end

  def index
    render json: Invoice.where(merchant_id: params[:id])
  end
end