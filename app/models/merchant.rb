class Merchant < ApplicationRecord
  validates :name, presence: true
  
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :items

  def self.total_revenue(qty)
    joins(:invoices)
    .joins(invoices: [:transactions])
    .where('transactions.result = ?', 'success')
    .joins('JOIN invoice_items ON invoice_items.invoice_id = invoices.id')
    .group('merchants.id')
    .order('SUM(invoice_items.unit_price * invoice_items.quantity) DESC')
    .limit(qty)
  end
end
