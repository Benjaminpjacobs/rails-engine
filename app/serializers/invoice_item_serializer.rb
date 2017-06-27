class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :unit_price
  
  def unit_price
    (object.unit_price.to_f/100).to_s
  end
  
end