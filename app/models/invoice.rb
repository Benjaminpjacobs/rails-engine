class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer
  belongs_to :merchant
  
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.calculate_revenue_by(date)
    joins(:invoice_items)
    .where("invoices.created_at = ? ", date)
    .sum('unit_price * quantity')
  end
end
