class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  default_scope {select(:id, :item_id, :invoice_id, :quantity, :unit_price)}
end
