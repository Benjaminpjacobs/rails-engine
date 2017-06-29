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
      collect_invoices(date)
      .joins(:transactions)
      .merge(Transaction.successful)
      .joins(:invoice_items)
      .sum("quantity * unit_price")
  end

  def favorite_customer
    customers
    .joins(invoices: [:transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order('count(customers.id) desc')
    .limit(1)
    .first
  end

  private

    def collect_invoices(date)
      if date
        self.invoices.where("invoices.created_at = ? ", date)
      else
        self.invoices
      end
    end
end
