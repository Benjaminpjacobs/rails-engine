class RevenueSerializer < ActiveModel::Serializer
  include PriceFormat
  attribute :revenue

  def revenue
    format_price(object)
  end
end
