class TotalRevenueSerializer < ActiveModel::Serializer
  include PriceFormat
  attribute :total_revenue

  def total_revenue
    format_price(object)
  end

end