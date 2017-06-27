module UnitPrice
  extend ActiveSupport::Concern

  def unit_price
    price = {}
    price[:unit_price] = unit_price_convert if params[:unit_price]
    return price
  end

  def unit_price_convert
    (params[:unit_price].to_f * 100).round
  end
  
end
