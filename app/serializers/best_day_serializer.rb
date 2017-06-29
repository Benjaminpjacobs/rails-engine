class BestDaySerializer < ActiveModel::Serializer
  attribute :best_day

  def best_day
    object.strftime("%FT%T.%LZ")
  end
end
