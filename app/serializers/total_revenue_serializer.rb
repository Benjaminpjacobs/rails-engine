class TotalRevenueSerializer < ActiveModel::Serializer
  attribute :total_revenue

  def total_revenue
    (object.to_f/100).to_s
  end

end