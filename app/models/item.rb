class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  scope :created_at, ->(time) { where("created_at = ?", time).order(:id) }
  scope :updated_at, ->(time) { where("updated_at = ?", time).order(:id) }
  scope :first_created, ->(time) { where("created_at = ?", time).order(:id).limit(1).first }
  scope :first_updated, ->(time) { where("updated_at = ?", time).order(:id).limit(1).first }
end
