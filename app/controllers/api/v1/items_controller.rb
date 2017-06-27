class Api::V1::ItemsController < ApplicationController
  def index
    return render json: Item.all
  end

  def show
    return render json: Item.find(params[:id])
  end
end