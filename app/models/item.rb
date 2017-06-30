class Item < ApplicationRecord
  validates :name, :description, :unit_price, presence: true

  belongs_to :merchant
  
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope {order(:id)}

  def self.by_most_revenue(limit)
    unscoped
    .joins(:invoice_items)
    .group(:id)
    .order('sum(invoice_items.unit_price * invoice_items.quantity) DESC')
    .limit(limit.to_i)
  end
  
  def best_day
    invoices
      .select('invoices.created_at')
      .joins(:invoice_items)
      .group(:id, :created_at)
      .order("sum(invoice_items.quantity) DESC, invoices.created_at ASC")
      .limit(1)
      .first
      .created_at
  end

  def self.by_most_items(qty)
   unscoped
     .joins(:invoice_items)
     .group(:id)
     .order("sum(invoice_items.quantity) DESC") 
     .limit(qty)
  end

  def revenue
    unscoped
    .invoices
    .joins(:transactions)
    .merge(Transaction.successful)
    .joins(:invoice_items)
    .sum("quantity * unit_price")
  end
end
