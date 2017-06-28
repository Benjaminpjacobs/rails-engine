class Merchant < ApplicationRecord
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

  def revenue(date=nil)
    if date.nil?
      display_revenue(
        invoices
        .joins(:transactions)
        .where(transactions: { result: "success" })
        .joins(:invoice_items)
        .sum("quantity * unit_price")
      )
    else
      display_revenue(
        invoices
        .where("invoices.created_at = ? ", date)
        .joins(:transactions)
        .where(transactions: { result: "success" })
        .joins(:invoice_items)
        .sum("quantity * unit_price")
      )
    end
  end

  def display_revenue(value)
    { "revenue" => (value.to_f/100).to_s }
  end
end
