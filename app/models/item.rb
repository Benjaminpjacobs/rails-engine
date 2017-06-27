class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  scope :created_at, ->(time) { where("created_at = ?", time).order(:id) }
  scope :updated_at, ->(time) { where("updated_at = ?", time).order(:id) }
  scope :first_created, ->(time) { where("created_at = ?", time).order(:id).limit(1).first }
  scope :first_updated, ->(time) { where("updated_at = ?", time).order(:id).limit(1).first }

  def self.most_revenue(limit)
    joins(:invoice_items)
    .group('items.id')
    .order('sum(invoice_items.unit_price * invoice_items.quantity) DESC')
    .limit(limit.to_i)
  end

  def revenue
    invoices
    .joins(:transactions)
    .where("transaction.result = ?", "success")
    .joins(:invoice_items)
    .sum("quantity * unit_price")
  end
end
