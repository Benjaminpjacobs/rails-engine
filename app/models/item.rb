class Item < ApplicationRecord
  validates :name, :description, :unit_price, presence: true

  belongs_to :merchant
  
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope {order(:id)}

  def self.most_revenue(limit)
    self.unscoped
    .joins(:invoice_items)
    .group('items.id')
    .order('sum(invoice_items.unit_price * invoice_items.quantity) DESC')
    .limit(limit.to_i)
  end

  def revenue
    invoices
    .unscoped
    .joins(:transactions)
    .merge(Transaction.successful)
    .joins(:invoice_items)
    .sum("quantity * unit_price")
  end
end
