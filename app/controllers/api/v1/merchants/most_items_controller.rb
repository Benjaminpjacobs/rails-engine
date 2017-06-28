class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    return render json: Merchant.most_items(params[:quantity])
  end
end
