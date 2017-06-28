module PriceFormat
  extend ActiveSupport::Concern
  def format_price(num)
    (num.to_f/100).to_s
  end
end