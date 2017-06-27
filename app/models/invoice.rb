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

  def self.total_revenue(date=nil)
    {"total_revenue" => (calculate_revenue_by(date).to_f/100).to_s} if date
  end
end
