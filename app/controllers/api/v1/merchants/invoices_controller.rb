class Api::V1::Merchants::InvoicesController < ApplicationController
  include Swagger::Docs::Methods

  swagger_controller :merchants, 'Merchants Invoices Controller'

  swagger_api :index do
    summary "Fetches invoices associated with single merchant"
    notes "This returns the invoices from a single merchant"
    param :path, :id, :integer, :required, "id"
  end

  def index
    render json: Invoice.where(merchant_id: params[:id])
  end
end