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

  def self.most_items(qty)
    joins(invoices: :transactions)
      .merge(Transaction.successful)
      .joins("JOIN invoice_items ON invoice_items.invoice_id = invoices.id")
      .group(:id)
      .order("sum(invoice_items.quantity) DESC")
      .limit(qty)
  end


  def revenue(date=nil)
    if date.nil?
      invoices
      .joins(:transactions)
      .merge(Transaction.successful)
      .joins(:invoice_items)
      .sum("quantity * unit_price")
    else
      invoices
      .where("invoices.created_at = ? ", date)
      .joins(:transactions)
      .where(transactions: { result: "success" })
      .joins(:invoice_items)
      .sum("quantity * unit_price")
    end
  end

  def self.favorite_merchant(customer_id)
    customer_id = CleanInput.for_sql(customer_id)
    joins(invoices: :transactions)
      .merge(Transaction.successful)
      .where('invoices.customer_id = ?', customer_id)
      .group(:id)
      .order("count(invoices.id) DESC")
      .limit(1).first
  end

  def display_revenue(value)
    { "revenue" => (value.to_f/100).to_s }
  end
end
