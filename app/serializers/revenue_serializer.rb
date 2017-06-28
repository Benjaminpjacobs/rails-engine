class RevenueSerializer < ActiveModel::Serializer
  attribute :revenue

  def revenue
    (object.to_f/100).to_s
  end

end