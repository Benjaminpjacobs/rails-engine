class Merchant < ApplicationRecord
  validates :name, presence: true
  
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :items

  def self.total_revenue(qty)
    joins(:invoices)
    .joins(invoices: [:transactions])
    .merge(Transaction.successful)
    .joins(invoices: [:invoice_items])
    .group(:id)
    .order('SUM(invoice_items.unit_price * invoice_items.quantity) DESC')
    .limit(qty)
  end

  def revenue
    invoices
    .joins(:transactions)
    .merge(Transaction.successful)
    .joins(:invoice_items)
    .sum("quantity * unit_price")
  end
end
